# frozen_string_literal: true

require 'net/http'
require 'json'

module RSpec
  module Llama
    class OpenaiModelRunner
      Error = Class.new(StandardError)

      DEFAULT_BASE_URL = 'https://api.openai.com/v1'
      CHAT_COMPLETIONS_PATH = '/chat/completions'

      # @param [String] access_token
      # @param [String] base_url
      # @param [String] organization_id
      def initialize(access_token:, base_url: DEFAULT_BASE_URL, organization_id: nil, project_id: nil)
        @access_token = access_token
        @base_url = base_url
        @organization_id = organization_id || ENV.fetch('OPENAI_ORGANIZATION_ID')
        @project_id = project_id || ENV.fetch('OPENAI_PROJECT_ID')
      end

      # @param [RSpec::Llama::ModelConfiguration] configuration
      # @param [RSpec::Llama::ModelPrompt] prompt
      #
      # @return [RSpec::Llama::OpenaiModelRunnerResult]
      def call(configuration, prompt)
        messages = [{ role: 'user', content: prompt.message }]
        response = execute_request(CHAT_COMPLETIONS_PATH, { **configuration.to_h, messages: })

        RSpec::Llama::OpenaiModelRunnerResult.new(response)
      end

      private

      attr_reader :access_token, :base_url, :organization_id, :project_id

      def request_headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{access_token}",
          'OpenAI-Organization' => organization_id,
          'OpenAI-Project' => project_id
        }
      end

      def execute_request(path, params)
        response = Net::HTTP.post(URI("#{base_url}#{path}"), JSON.dump(params), request_headers)
        json_response = JSON.parse(response.body, symbolize_names: true)
        return json_response if response.is_a?(Net::HTTPSuccess)

        raise Error, json_response.dig(:error, :message)
      end
    end
  end
end
