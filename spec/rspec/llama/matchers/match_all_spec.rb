# frozen_string_literal: true

RSpec.describe RSpec::Llama::Matchers::MatchAll do
  subject(:matcher) { described_class.new(*expected) }

  let(:actual) { 'This result contains foo and bar' }

  context 'with strings' do
    context 'when all expected values are matched' do
      let(:expected) { ['foo', 'bar'] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} not to match all of #{expected.inspect}, but it matched all."
        )
      end
    end

    context 'when not all expected values are matched' do
      let(:expected) { ['foo', 'bar', 'baz'] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match all of #{expected.inspect}, but it did not match: [\"baz\"]"
        )
      end
    end
  end

  context 'with regular expressions' do
    context 'when all patterns match the result' do
      let(:expected) { [/foo/, /bar/] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} not to match all of #{expected.inspect}, but it matched all."
        )
      end
    end

    context 'when a pattern does not match' do
      let(:expected) { [/foo/, /baz/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match all of #{expected.inspect}, but it did not match: [/baz/]"
        )
      end
    end
  end

  context 'with both strings and regular expressions' do
    let(:expected) { ['foo', /bar/] }

    context 'when both string and regular expression match' do
      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.inspect} not to match all of #{expected.inspect}, but it matched all."
        )
      end
    end

    context 'when not all values match' do
      let(:expected) { ['foo', /baz/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.inspect} to match all of #{expected.inspect}, but it did not match: [/baz/]"
        )
      end
    end
  end

  context 'with empty actual string' do
    let(:actual) { '' }
    let(:expected) { ['foo', 'bar'] }

    it 'returns false for #matches?' do
      expect(matcher.matches?(actual)).to be false
    end

    it 'returns correct failure message' do
      matcher.matches?(actual)
      expect(matcher.failure_message).to eq(
        "expected #{actual.inspect} to match all of #{expected.inspect}, but it did not match: [\"foo\", \"bar\"]"
      )
    end
  end

  context 'with ModelRunnerResult as an actual' do
    let(:actual) { instance_double(RSpec::Llama::BaseModelRunnerResult, to_s: 'This result contains foo and bar') }
    let(:expected) { ['foo', 'bar'] }

    it 'returns true for #matches?' do
      expect(matcher.matches?(actual)).to be true
    end

    it 'returns correct negated failure message' do
      matcher.matches?(actual)
      expect(matcher.failure_message_when_negated).to eq(
        "expected #{actual.to_s.inspect} not to match all of #{expected.inspect}, but it matched all."
      )
    end
  end
end
