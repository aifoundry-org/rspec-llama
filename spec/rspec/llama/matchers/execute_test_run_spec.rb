# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'execute_test_run matcher' do
  let(:api_client) { instance_double('Rspec::Llama::ApiClient') }

  before do
    allow(Rspec::Llama::ApiClient).to receive(:new).and_return(api_client)
  end

  it 'passes when the test run is successful' do
    allow(Rspec::Llama.api_client).to receive(:execute_test_run).with(1).and_return({ 'success' => true })

    expect(true).to execute_test_run(1)
  end

  it 'fails when the test run is not successful' do
    allow(Rspec::Llama.api_client).to receive(:execute_test_run).with(2).and_return({ 'success' => false })

    expect(false).to execute_test_run(2)
  end
end
