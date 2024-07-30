# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'helpers' do
  context 'execute_test_run' do
    let(:api_client) { instance_double('Rspec::Llama::ApiClient') }
    let(:params) do
      { name: 'Test', prompt_id: 1, calls: 1, assertion_ids: [8], model_version_ids: [6], passing_threshold: 100 }
    end

    before do
      allow(Rspec::Llama::ApiClient).to receive(:new).and_return(api_client)
    end

    it 'passes when the test run is successful' do
      allow(Rspec::Llama.api_client).to receive(:execute_test_run).with(params).and_return({ 'success' => true })

      expect(execute_test_run(params)).to eq({ 'success' => true })
    end

    it 'fails when the test run is not successful' do
      allow(Rspec::Llama.api_client).to receive(:execute_test_run).with(params).and_return({ 'success' => false })

      expect(execute_test_run(params)).to eq({ 'success' => false })
    end
  end
end
