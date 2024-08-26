# frozen_string_literal: true

RSpec.describe RSpec::Llama::ExcludeAllModelAssertion do
  describe '#call' do
    let(:assertion) { described_class.new('value1', 'value2') }

    context 'when none of the values are included in the result' do
      it 'passes if none of the values are found in the result' do
        result = 'This result does not contain the values'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when any value is included in the result' do
      it 'fails if one value is found in the result' do
        result = 'This result contains value1'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if another value is found in the result' do
        result = 'This result contains value2'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end
end
