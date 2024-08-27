# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamaCppModelRunnerResult do
  subject(:runner_result) { described_class.new(output).to_s }

  let(:output) { 'Ruby is a dynamic, open-source programming language' }

  describe '#to_s' do
    it 'returns the result as a string with whitespace stripped' do
      expect(runner_result).to eq('Ruby is a dynamic, open-source programming language')
    end

    context 'with leading and trailing whitespace' do
      let(:output) { '   Ruby is a dynamic language   ' }

      it 'strips whitespaces' do
        expect(runner_result).to eq('Ruby is a dynamic language')
      end
    end
  end
end
