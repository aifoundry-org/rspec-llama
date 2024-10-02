# frozen_string_literal: true

RSpec.describe RSpec::Llama::Matchers::MatchNone do
  subject(:matcher) { described_class.new(*expected) }

  let(:actual) { 'This result contains foo and bar' }

  context 'with strings' do
    context 'when none of the expected values are matched' do
      let(:expected) { ['baz', 'qux'] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} to match at least one of #{expected.inspect}, but none matched."
        )
      end
    end

    context 'when any expected value is matched' do
      let(:expected) { ['foo', 'baz'] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match none of #{expected.inspect}, but it matched: [\"foo\"]"
        )
      end
    end
  end

  context 'with regular expressions' do
    context 'when none of the patterns match the result' do
      let(:expected) { [/baz/, /qux/] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} to match at least one of #{expected.inspect}, but none matched."
        )
      end
    end

    context 'when any pattern matches the result' do
      let(:expected) { [/foo/, /baz/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match none of #{expected.inspect}, but it matched: [/foo/]"
        )
      end
    end
  end

  context 'with both strings and regular expressions' do
    let(:expected) { ['baz', /qux/] }

    context 'when none of the string or regular expression values match' do
      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} to match at least one of #{expected.inspect}, but none matched."
        )
      end
    end

    context 'when any value or pattern matches' do
      let(:expected) { ['foo', /baz/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match none of #{expected.inspect}, but it matched: [\"foo\"]"
        )
      end
    end
  end

  context 'with empty actual string' do
    let(:actual) { '' }
    let(:expected) { ['foo', 'bar'] }

    it 'returns true for #matches?' do
      expect(matcher.matches?(actual)).to be true
    end

    it 'returns correct negated failure message' do
      matcher.matches?(actual)
      expect(matcher.failure_message_when_negated).to eq(
        "expected #{actual.inspect} to match at least one of #{expected.inspect}, but none matched."
      )
    end
  end

  context 'with ModelRunnerResult as an actual' do
    let(:actual) { instance_double(RSpec::Llama::BaseModelRunnerResult, to_s: 'This result contains foo and bar') }
    let(:expected) { ['foo', 'baz'] }

    it 'returns false for #matches?' do
      expect(matcher.matches?(actual)).to be false
    end

    it 'returns correct failure message' do
      matcher.matches?(actual)
      expect(matcher.failure_message).to eq(
        "expected #{actual.to_s.inspect} to match none of #{expected.inspect}, but it matched: [\"foo\"]"
      )
    end
  end
end
