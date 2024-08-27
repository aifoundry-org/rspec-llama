# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamaCppModelConfiguration do
  describe '#initialize' do
    it 'initializes with default options' do
      config = described_class.new(model: '/path/to/model')

      expect(config).to have_attributes(
        model: '/path/to/model', temperature: 0.5, predict: 500, additional_options: {}
      )
    end

    it 'allows overriding default values' do
      config = described_class.new(model: '/path/to/model', temperature: 0.7, threads: 8, predict: 200)

      expect(config).to have_attributes(
        model: '/path/to/model', temperature: 0.7, predict: 200, additional_options: { threads: 8 }
      )
    end
  end

  describe '#to_a' do
    it 'returns an array of CLI options including additional options' do
      config = described_class.new(
        model: '/path/to/model', temperature: 0.7, threads: 8, verbose: true, log_file: '/path/to/logfile.log'
      )

      expect(config.to_a).to eq(
        [
          '--model', '/path/to/model', '--temp', '0.7', '--predict', '500',
          '--threads', '8', '--verbose', '--log-file', '/path/to/logfile.log'
        ]
      )
    end
  end
end
