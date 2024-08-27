# frozen_string_literal: true

RSpec.describe RSpec::Llama::ExcludeAllModelAssertion do
  context 'with strings' do
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

  context 'with regular expressions' do
    let(:assertion) { described_class.new(/value\d/, /pattern\d+/) }

    context 'when none of the patterns match the result' do
      it 'passes if none of the regular expressions match' do
        result = 'This result contains no matching patterns'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when any regular expression matches the result' do
      it 'fails if one pattern matches' do
        result = 'This result contains value1'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if another pattern matches' do
        result = 'This result matches pattern123'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end

  context 'with both strings and regular expressions' do
    let(:assertion) { described_class.new('string_value', /regex_pattern\d+/) }

    context 'when none of the values (string or regex) are present in the result' do
      it 'passes if neither the string nor the regex matches the result' do
        result = 'This result contains no matching values or patterns'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end
    end

    context 'when any value (string or regex) is found in the result' do
      it 'fails if the string is found' do
        result = 'This result contains string_value'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end

      it 'fails if the regular expression matches' do
        result = 'This result matches regex_pattern123'
        assertion_result = assertion.call(result)
        expect(assertion_result).not_to be_passed
      end
    end
  end
end
