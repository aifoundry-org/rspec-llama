# frozen_string_literal: true

require 'bundler/setup'
require 'rspec/llama'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.api_endpoint = 'https://api.example.com/execute_test_run'
  config.auth_endpoint = 'https://api.example.com/authenticate'
  config.api_creds = { username: 'your_username', password: 'your_password' }
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
