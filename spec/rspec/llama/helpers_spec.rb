# frozen_string_literal: true

RSpec.describe RSpec::Llama::Helpers do
  subject(:helpers) { Class.new { include RSpec::Llama::Helpers }.new }

  describe '#build_model_configuration' do
    it 'raises an error for unsupported configuration type' do
      expect { helpers.build_model_configuration(:unsupported) }.to raise_error(
        'Unsupported model configuration type: unsupported'
      )
    end

    context 'with openai model configuration' do
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

    context 'with llama_cpp model configuration' do
      it 'builds a LlamaCppModelConfiguration with default options' do
        config = helpers.build_model_configuration(:llama_cpp, model: '/path/to/model')

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamaCppModelConfiguration,
          model: '/path/to/model',
          temperature: 0.5,
          predict: 500,
          stop: /\A<(?:end|user|assistant|endoftext|system)>\z/
        )
      end

      it 'builds a LlamaCppModelConfiguration with given options' do
        config = helpers.build_model_configuration(
          :llama_cpp, model: '/path/to/model', temperature: 0.7, predict: 100, stop: /some regexp/
        )

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamaCppModelConfiguration,
          model: '/path/to/model',
          temperature: 0.7,
          predict: 100,
          stop: /some regexp/
        )
      end
    end

    context 'with llamafile_cli model configuration' do
      it 'builds a LlamafileCliModelConfiguration with default options' do
        config = helpers.build_model_configuration(:llamafile_cli)

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamafileCliModelConfiguration,
          temperature: 0.5,
          predict: 500
        )
      end

      it 'builds a LlamaCppModelConfiguration with given options' do
        config = helpers.build_model_configuration(
          :llamafile_cli, temperature: 0.7, threads: 8, predict: 100
        )

        expect(config).to have_attributes(
          class: RSpec::Llama::LlamafileCliModelConfiguration,
          temperature: 0.7,
          predict: 100,
          additional_options: { threads: 8 }
        )
      end
    end

    context 'with ollama model configuration' do
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

    it 'builds a LlamafileCliModelRunner' do
      runner = helpers.build_model_runner(:llamafile_cli, path: '/path/to/llamafile')

      expect(runner).to have_attributes(
        class: RSpec::Llama::LlamafileCliModelRunner,
        path: '/path/to/llamafile'
      )
    end
  end
end
