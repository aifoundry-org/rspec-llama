# frozen_string_literal: true

RSpec.describe RSpec::Llama::OpenaiModelRunner do
  subject(:call_runner!) { described_class.new(**runner_options).call(model_configuration, model_prompt) }

  let(:runner_options) { { access_token: } }
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

    it 'returns the response hash' do
      VCR.use_cassette('openai_model_runner/valid_access_token') do
        result = call_runner!

        expect(result).to have_attributes(
          class: RSpec::Llama::OpenaiModelRunnerResult,
          to_s: 'Yes, Minsk is the capital of Belarus.'
        )
      end
    end
  end

  context 'with invalid access token' do
    let(:access_token) { 'invalid_token' }

    it 'raises error' do
      VCR.use_cassette('openai_model_runner/invalid_access_token') do
        expect { call_runner! }.to raise_error
      end
    end
  end
end
