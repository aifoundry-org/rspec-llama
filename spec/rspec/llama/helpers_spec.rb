# frozen_string_literal: true

RSpec.describe RSpec::Llama::Helpers do
  subject(:helpers) { Class.new { include RSpec::Llama::Helpers }.new }

  describe '#build_model_prompt' do
    it 'builds a ModelPrompt with a message' do
      prompt = helpers.build_model_prompt('What is the capital of France?')

      expect(prompt).to have_attributes(
        class: RSpec::Llama::ModelPrompt,
        message: 'What is the capital of France?'
      )
    end
  end

  describe '#build_model_configuration' do
    it 'raises an error for unsupported configuration type' do
      expect { helpers.build_model_configuration(:unsupported) }.to raise_error(
        'Unsupported model configuration type: unsupported'
      )
    end

    context 'model configuration for openai' do
      it 'builds an OpenaiModelConfiguration with default options' do
        config = helpers.build_model_configuration(:openai)

        expect(config).to have_attributes(
          class: RSpec::Llama::OpenaiModelConfiguration,
          model: 'gpt-3.5-turbo',
          temperature: 0.5
        )
      end

      it 'builds an OpenaiModelConfiguration with given options' do
        config = helpers.build_model_configuration(:openai, model: 'gpt-4o-mini', temperature: 0.7)

        expect(config).to have_attributes(
          class: RSpec::Llama::OpenaiModelConfiguration,
          model: 'gpt-4o-mini',
          temperature: 0.7
        )
      end
    end

    context 'model configuration for llama_cpp' do
      it 'builds a LlamaCppModelConfiguration with default options' do
        config = helpers.build_model_configuration(:llama_cpp)

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamaCppModelConfiguration,
          temperature: 0.5,
          n_predict: 500,
          stop: /\A<(?:end|user|assistant|endoftext|system)>\z/
        )
      end

      it 'builds a LlamaCppModelConfiguration with given options' do
        config = helpers.build_model_configuration(
          :llama_cpp, temperature: 0.7, n_predict: 100, stop: /some regexp/
        )

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamaCppModelConfiguration,
          temperature: 0.7,
          n_predict: 100,
          stop: /some regexp/
        )
      end
    end

    context 'model configuration for ollama' do
      it 'builds an OllamaModelConfiguration with default options' do
        config = helpers.build_model_configuration(:ollama)

        expect(config).to have_attributes(
          class: RSpec::Llama::OllamaModelConfiguration,
          model: 'llama3.1'
        )
      end

      it 'builds an OllamaModelConfiguration with given options' do
        config = helpers.build_model_configuration(:ollama, model: 'gemma2')

        expect(config).to have_attributes(
          class: RSpec::Llama::OllamaModelConfiguration,
          model: 'gemma2'
        )
      end
    end
  end

  describe '#build_model_runner' do
    it 'raises an error for unsupported runner type' do
      expect { helpers.build_model_runner(:unsupported) }.to raise_error(
        'Unsupported model runner type: unsupported'
      )
    end

    it 'builds an OpenaiModelRunner' do
      runner = helpers.build_model_runner(:openai, access_token: 'fake_token')

      expect(runner).to have_attributes(
        class: RSpec::Llama::OpenaiModelRunner
      )
    end
  end

  describe '#build_model_assertion' do
    it 'raises an error for unsupported assertion type' do
      expect { helpers.build_model_assertion(:unsupported, 'value') }.to raise_error(
        'Unsupported assertion type: unsupported'
      )
    end

    it 'builds an IncludeAllModelAssertion' do
      assertion = helpers.build_model_assertion(:include_all, 'Expected Text')

      expect(assertion).to have_attributes(
        class: RSpec::Llama::IncludeAllModelAssertion,
        values: ['Expected Text']
      )
    end

    it 'builds an IncludeAnyModelAssertion' do
      assertion = helpers.build_model_assertion(:include_any, 'Expected Text')

      expect(assertion).to have_attributes(
        class: RSpec::Llama::IncludeAnyModelAssertion,
        values: ['Expected Text']
      )
    end

    it 'builds an ExcludeAllModelAssertion' do
      assertion = helpers.build_model_assertion(:exclude_all, 'Expected Text')

      expect(assertion).to have_attributes(
        class: RSpec::Llama::ExcludeAllModelAssertion,
        values: ['Expected Text']
      )
    end
  end
end
