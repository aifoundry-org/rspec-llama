# frozen_string_literal: true

module Rspec
  module Llama
    class ApiClient
      def initialize(endpoint, creds, auth_endpoint)
        @endpoint = endpoint
        @creds = creds
        @auth_endpoint = auth_endpoint
      end

      def authenticate
        uri = URI(@auth_endpoint)
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = @creds.to_json

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end

        JSON.parse(response.body)['token']
      end

      def execute_test_run(test_id)
        uri = URI("#{@endpoint}/#{test_id}")
        req = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json')
        req['Authorization'] = "Bearer #{token}"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end

        JSON.parse(response.body)
      end

      private

      def token
        @token ||= authenticate
      end
    end
  end
end
