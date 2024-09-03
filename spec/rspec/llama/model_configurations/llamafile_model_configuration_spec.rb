# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamafileModelConfiguration do
  describe '#initialize' do
    it 'initializes with default options' do
      config = described_class.new

      expect(config).to have_attributes(temperature: 0.5, predict: 500, additional_options: {})
    end

    it 'allows overriding default values' do
      config = described_class.new(temperature: 0.7, threads: 8, predict: 200)

      expect(config).to have_attributes(
        temperature: 0.7, predict: 200, additional_options: { threads: 8 }
      )
    end
  end

  describe '#to_a' do
    it 'returns an array of CLI options including additional options' do
      config = described_class.new(temperature: 0.7, threads: 8, predict: 200)

      expect(config.to_a).to eq(
        ['--cli', '--silent-prompt', '--temp', '0.7', '--n-predict', '200', '--threads', '8']
      )
    end
  end
end
