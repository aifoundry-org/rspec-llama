# frozen_string_literal: true

module Rspec
  module Llama
    class ApiClient
      attr_reader :endpoint, :creds, :auth_endpoint

      def initialize(endpoint, creds, auth_endpoint)
        @endpoint = endpoint
        @creds = creds
        @auth_endpoint = auth_endpoint

        set_token
      end

      def authenticate
        uri = URI(auth_endpoint)
        api_execute(:post, uri, creds)
      end

      def fetch_all_models
        uri = URI("#{endpoint}/models.json")
        api_execute(:get, uri)
      end

      def fetch_all_prompts
        uri = URI("#{endpoint}/prompts.json")
        api_execute(:get, uri)
      end

      def fetch_all_assertions
        uri = URI("#{endpoint}/assertions.json")
        api_execute(:get, uri)
      end

      def fetch_all_model_versions(model_id)
        uri = URI("#{endpoint}/models/#{model_id}/model_versions.json")
        api_execute(:get, uri)
      end

      def fetch_assertion_results(test_result_id)
        uri = URI("#{endpoint}/test_results/#{test_result_id}/assertion_results.json")
        api_execute(:get, uri)
      end

      def fetch_model(id)
        uri = URI("#{endpoint}/models/#{id}.json")
        api_execute(:get, uri)
      end

      def fetch_test_run(test_run_id)
        uri = URI("#{endpoint}/test_runs/#{test_run_id}.json")
        api_execute(:get, uri)
      end

      def fetch_test_model_version_run(test_model_version_run_id)
        uri = URI("#{endpoint}/test_model_version_runs/#{test_model_version_run_id}.json")
        api_execute(:get, uri)
      end

      def fetch_test_result(test_result_id)
        uri = URI("#{endpoint}/test_results/#{test_result_id}.json")
        api_execute(:get, uri)
      end

      def create_model(**opts)
        uri = URI("#{endpoint}/models.json")
        api_execute(:post, uri, opts)
      end

      def create_model_version(model_id, opts)
        uri = URI("#{endpoint}/models/#{model_id}/model_versions.json")
        api_execute(:post, uri, opts)
      end

      def create_prompt(model_id, **opts)
        params = { prompt: { value: opts[:value], name: opts[:name] } }
        uri = URI("#{endpoint}/prompts.json")
        api_execute(:post, uri, params)
      end

      def create_assertion(model_id, **opts)
        uri = URI("#{endpoint}/assertions.json")
        api_execute(:post, uri, opts)
      end

      def execute_test_run(params)
        uri = URI("#{endpoint}/test_runs.json")
        api_execute(:post, uri, params)
      end

      private

      def api_execute(method, uri, params = nil)
        is_auth_req = uri.to_s.include?('sign_in')

        req = Net::HTTP.const_get(method.capitalize).new(uri, 'Content-Type' => 'application/json')
        req['Authorization'] = "Bearer #{token}" unless is_auth_req
        req.body = params.to_json if params

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end

        is_auth_req ? response : JSON.parse(response.body)
      rescue StandardError => e
        # should be implemented
      end

      def token
        @token ||= authenticate['Authorization'].gsub('Bearer ', '')
      end
      alias_method :set_token, :token
    end
  end
end
