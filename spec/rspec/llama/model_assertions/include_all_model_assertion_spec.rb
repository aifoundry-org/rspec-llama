# frozen_string_literal: true

RSpec.describe RSpec::Llama::IncludeAllModelAssertion do
  describe '#call' do
    let(:assertion) { described_class.new('value1', 'value2') }

    context 'when all values are included in the result' do
      it 'passes if all values are found in the result' do
        result = 'This result contains value1 and value2'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when not all values are included in the result' do
      it 'fails if one value is missing from the result' do
        result = 'This result contains value1'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if no values are found in the result' do
        result = 'No expected values here'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end
end
