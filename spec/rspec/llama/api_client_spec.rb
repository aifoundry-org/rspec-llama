# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Llama::ApiClient do
  let(:endpoint) { 'https://api.example.com/test_runs.json' }
  let(:auth_endpoint) { 'https://api.example.com/authenticate' }
  let(:creds) { { user: { email: 'your_username', password: 'your_password' } } }
  let(:api_client) { described_class.new(endpoint, creds, auth_endpoint) }
  let(:params) do
    { name: 'Test', prompt_id: 1, calls: 1, assertion_ids: [8], model_version_ids: [6], passing_threshold: 100 }
  end

  describe '#authenticate' do
    it 'returns a token' do
      stub_request(:post, auth_endpoint).with(
        body: creds.to_json,
        headers: { 'Content-Type' => 'application/json' }
      ).to_return(
        headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer fake_token' }
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
        headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer fake_token' }
      )

      allow(api_client).to receive(:authenticate).and_return('fake_token')
    end

    it 'returns the result of the test run' do
      stub_request(:post, "#{endpoint}/test_runs.json")
        .with(
          body: params.to_json,
          headers: { 'Authorization' => 'Bearer fake_token' }
        )
        .to_return(body: { success: true }.to_json, headers: { 'Content-Type' => 'application/json' })

      result = api_client.execute_test_run(params)
      expect(result['success']).to be true
    end
  end
end
