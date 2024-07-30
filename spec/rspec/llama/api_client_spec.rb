# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Llama::ApiClient do
  let(:endpoint) { 'https://api.example.com/execute_test_run' }
  let(:auth_endpoint) { 'https://api.example.com/authenticate' }
  let(:creds) { { username: 'your_username', password: 'your_password' } }
  let(:api_client) { described_class.new(endpoint, creds, auth_endpoint) }

  describe '#authenticate' do
    it 'returns a token' do
      stub_request(:post, auth_endpoint).with(
        body: creds.to_json,
        headers: { 'Content-Type' => 'application/json' }
      ).to_return(
        body: { token: 'fake_token' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      expect(api_client.authenticate).to eq('fake_token')
    end
  end

  describe '#execute_test_run' do
    before do
      stub_request(:post, auth_endpoint).with(
        body: creds.to_json,
        headers: { 'Content-Type' => 'application/json' }
      ).to_return(
        body: { token: 'fake_token' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      allow(api_client).to receive(:authenticate).and_return('fake_token')
    end

    it 'returns the result of the test run' do
      stub_request(:get, "#{endpoint}/1")
        .with(headers: { 'Authorization' => 'Bearer fake_token' })
        .to_return(body: { success: true }.to_json, headers: { 'Content-Type' => 'application/json' })

      result = api_client.execute_test_run(1)
      expect(result['success']).to be true
    end
  end
end
