# frozen_string_literal: true

RSpec.describe RSpec::Llama::OpenaiModelRunner do
  subject(:call_runner!) { described_class.new(**runner_options).call(model_configuration, model_prompt) }

  let(:runner_options) { { access_token:, organization_id:, project_id: } }
  let(:organization_id) { ENV.fetch('OPENAI_ORGANIZATION_ID') }
  let(:project_id) { ENV.fetch('OPENAI_PROJECT_ID') }

  let(:model_configuration) do
    instance_double(
      RSpec::Llama::OpenaiModelConfiguration,
      to_h: { model: 'gpt-3.5-turbo', temperature: 0.5 }
    )
  end
  let(:model_prompt) do
    instance_double(RSpec::Llama::ModelPrompt, message: 'Is Minsk the capital of Belarus?')
  end

  context 'with valid access token' do
    let(:access_token) { ENV.fetch('OPENAI_ACCESS_TOKEN') }

    it 'returns the response hash', vcr: { cassette_name: 'openai_model_runner/valid_access_token' } do
      result = call_runner!

      expect(result).to have_attributes(
        class: RSpec::Llama::OpenaiModelRunnerResult,
        to_s: 'Yes, Minsk is the capital of Belarus.'
      )
    end
  end

  context 'with invalid organization ID' do
    let(:access_token) { ENV.fetch('OPENAI_ACCESS_TOKEN') }
    let(:organization_id) { 'invalid_organization_id' }

    it 'raises error', vcr: { cassette_name: 'openai_model_runner/invalid_organization_id' } do
      expect { call_runner! }.to raise_error(
        RSpec::Llama::OpenaiModelRunner::Error,
        'No such organization: invalid_organization_id.'
      )
    end
  end

  context 'with invalid project ID' do
    let(:access_token) { ENV.fetch('OPENAI_ACCESS_TOKEN') }
    let(:project_id) { 'invalid_project_id' }

    it 'raises error', vcr: { cassette_name: 'openai_model_runner/invalid_project_id' } do
      expect { call_runner! }.to raise_error(
        RSpec::Llama::OpenaiModelRunner::Error,
        "The project 'invalid_project_id' does not exist in '#{organization_id}'"
      )
    end
  end

  context 'with invalid access token' do
    let(:access_token) { 'invalid_token' }

    it 'raises error', vcr: { cassette_name: 'openai_model_runner/invalid_access_token' } do
      expect { call_runner! }.to raise_error(
        RSpec::Llama::OpenaiModelRunner::Error,
        'Incorrect API key provided: invalid_*oken. You can find your API key at https://platform.openai.com/account/api-keys.'
      )
    end
  end
end
