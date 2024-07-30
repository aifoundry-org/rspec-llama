# frozen_string_literal: true

module Rspec
  module Llama
    class << self
      attr_accessor :api_client
    end

    RSpec.configure do |config|
      config.add_setting :api_endpoint
      config.add_setting :auth_endpoint
      config.add_setting :api_creds

      config.before(:suite) do
        Rspec::Llama.api_client = ApiClient.new(
          RSpec.configuration.api_endpoint,
          RSpec.configuration.api_creds,
          RSpec.configuration.auth_endpoint
        )
      end
    end
  end
end
