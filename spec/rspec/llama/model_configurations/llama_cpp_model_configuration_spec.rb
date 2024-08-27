# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamaCppModelConfiguration do
  describe '#initialize' do
    it 'initializes with default options' do
      config = described_class.new(model_path: '/models/llama')

      expect(config).to have_attributes(
        model_path: '/models/llama',
        temperature: 0.5,
        threads: 4,
        n_predict: -1
      )
    end

    it 'allows overriding default values' do
      config = described_class.new(
        model_path: '/models/llama',
        temperature: 0.7,
        threads: 8,
        n_predict: 200
      )

      expect(config).to have_attributes(
        model_path: '/models/llama',
        temperature: 0.7,
        threads: 8,
        n_predict: 200
      )
    end

    it 'stores additional options' do
      config = described_class.new(
        model_path: '/models/llama',
        verbose: true
      )

      expect(config.additional_options).to eq({ verbose: true })
    end
  end

  describe '#to_a' do
    it 'returns an array of CLI options including additional options' do
      config = described_class.new(
        model_path: '/models/llama',
        temperature: 0.7,
        threads: 8,
        verbose: true,
        'log-file': '/path/to/logfile.log'
      )

      expect(config.to_a).to eq(
        [
          '--model', '/models/llama', '--temp', '0.7', '--threads', '8',
          '--predict', '-1', '--verbose', '--log-file', '/path/to/logfile.log'
        ]
      )
    end
  end
end
