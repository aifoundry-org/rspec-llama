# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RSpec Configuration' do
  it 'configures the API endpoint' do
    expect(RSpec.configuration.api_endpoint).to eq('https://api.example.com/execute_test_run')
  end

  it 'configures the authentication endpoint' do
    expect(RSpec.configuration.auth_endpoint).to eq('https://api.example.com/authenticate')
  end

  it 'configures the API credentials' do
    expect(RSpec.configuration.api_creds).to eq({ username: 'your_username', password: 'your_password' })
  end
end
