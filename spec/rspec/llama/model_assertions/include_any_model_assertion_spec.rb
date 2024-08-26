# frozen_string_literal: true

RSpec.describe RSpec::Llama::IncludeAnyModelAssertion do
  describe '#call' do
    let(:assertion) { described_class.new('value1', 'value2') }

    context 'when any of the values are included in the result' do
      it 'passes if one value is found in the result' do
        result = 'This result contains value1'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end

      it 'passes if another value is found in the result' do
        result = 'This result contains value2'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when none of the values are included in the result' do
      it 'fails if no values are found in the result' do
        result = 'No expected values here'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_failed
      end
    end
  end
end
