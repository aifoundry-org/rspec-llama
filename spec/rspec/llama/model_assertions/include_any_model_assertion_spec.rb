# frozen_string_literal: true

RSpec.describe RSpec::Llama::IncludeAnyModelAssertion do
  describe '#call' do
    context 'with strings' do
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

    context 'with regular expressions' do
      let(:assertion) { described_class.new(/value\d/, /pattern\d+/) }

      context 'when any regular expression matches' do
        it 'passes if one pattern matches the result' do
          result = 'This result contains value1'
          assertion_result = assertion.call(result)
          expect(assertion_result).to be_passed
        end

        it 'passes if another pattern matches the result' do
          result = 'This result matches pattern123'
          assertion_result = assertion.call(result)
          expect(assertion_result).to be_passed
        end
      end

      context 'when no regular expression matches' do
        it 'fails if no patterns match the result' do
          result = 'No expected patterns here'
          assertion_result = assertion.call(result)
          expect(assertion_result).to be_failed
        end
      end
    end

    context 'with both strings and regular expressions' do
      let(:assertion) { described_class.new('string_value', /regex_pattern\d+/) }

      it 'passes if the string is found in the result' do
        result = 'This result contains string_value'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end

      it 'passes if the regular expression matches the result' do
        result = 'This result matches regex_pattern123'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_passed
      end

      it 'fails if neither the string nor the regex matches the result' do
        result = 'No matching patterns or strings here'
        assertion_result = assertion.call(result)
        expect(assertion_result).to be_failed
      end
    end
  end
end
