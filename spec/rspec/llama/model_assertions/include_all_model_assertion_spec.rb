# frozen_string_literal: true

RSpec.describe RSpec::Llama::IncludeAllModelAssertion do
  context 'with strings' do
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

  context 'with regular expressions' do
    let(:assertion) { described_class.new(/value\d/, /pattern\d+/) }

    context 'when all patterns match the result' do
      it 'passes if all regular expressions match' do
        result = 'This result contains value1 and pattern123'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when not all patterns match' do
      it 'fails if one regular expression does not match' do
        result = 'This result contains value1 but no pattern'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if none of the patterns match' do
        result = 'No expected patterns here'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end

  context 'with both strings and regular expressions' do
    let(:assertion) { described_class.new('string_value', /regex_pattern\d+/) }

    context 'when both string and regular expression match' do
      it 'passes if both string and regex are found in the result' do
        result = 'This result contains string_value and regex_pattern123'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when not all values (string or regex) match' do
      it 'fails if only the string is found' do
        result = 'This result contains string_value but no regex'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if only the regex is found' do
        result = 'This result contains regex_pattern123 but no string'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if neither the string nor the regex match' do
        result = 'No matching strings or regex patterns here'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end
end
