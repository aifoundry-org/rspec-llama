# frozen_string_literal: true

require 'openai'

module RSpec
  module Llama
    class OpenaiModelRunner < BaseModelRunner
      # @param [String] url
      # @param [String] access_token
      # @param [Numeric] request_timeout
      # @param [String] organization_id
      def initialize(access_token:, url: nil, request_timeout: nil, organization_id: nil,
                     api_type: nil, api_version: nil, log_errors: true, extra_headers: nil)
        client_options = {
          access_token:, uri_base: url, request_timeout:, organization_id:,
          api_type:, api_version:, log_errors:, extra_headers:
        }.compact
        @client = ::OpenAI::Client.new(client_options)
      end

      # @param [RSpec::Llama::ModelConfiguration] configuration
      # @param [RSpec::Llama::ModelPrompt] prompt
      # @return [Hash]
      def call(configuration, prompt)
        messages = prompt.messages.map do |message|
          { role: 'user', content: message }
        end

        client.chat(parameters: { **configuration.to_h, messages: })
      end

      private

      attr_reader :client
    end
  end
end
