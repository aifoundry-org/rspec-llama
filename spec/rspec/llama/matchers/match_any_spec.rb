# frozen_string_literal: true

RSpec.describe RSpec::Llama::Matchers::MatchAny do
  subject(:matcher) { described_class.new(*expected) }

  let(:actual) { 'This result contains foo and bar' }

  context 'with strings' do
    context 'when at least one expected value is matched' do
      let(:expected) { ['foo', 'baz'] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected that #{actual.inspect} would not match any of #{expected.inspect}, but it matched some."
        )
      end
    end

    context 'when none of the expected values are matched' do
      let(:expected) { ['baz', 'qux'] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected that #{actual.inspect} would match any of #{expected.inspect}, but none of them matched."
        )
      end
    end
  end

  context 'with regular expressions' do
    context 'when at least one pattern matches the result' do
      let(:expected) { [/foo/, /baz/] }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected that #{actual.inspect} would not match any of #{expected.inspect}, but it matched some."
        )
      end
    end

    context 'when none of the patterns match' do
      let(:expected) { [/baz/, /qux/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected that #{actual.inspect} would match any of #{expected.inspect}, but none of them matched."
        )
      end
    end
  end

  context 'with both strings and regular expressions' do
    let(:expected) { ['foo', /qux/] }

    context 'when at least one string or regular expression matches' do
      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns correct negated failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected that #{actual.inspect} would not match any of #{expected.inspect}, but it matched some."
        )
      end
    end

    context 'when none of the values or patterns match' do
      let(:expected) { ['baz', /qux/] }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected that #{actual.inspect} would match any of #{expected.inspect}, but none of them matched."
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
        "expected that #{actual.inspect} would match any of #{expected.inspect}, but none of them matched."
      )
    end
  end

  context 'with ModelRunnerResult as an actual' do
    let(:actual) { instance_double(RSpec::Llama::BaseModelRunnerResult, to_s: 'This result contains foo and bar') }
    let(:expected) { ['bar', 'baz'] }

    it 'returns true for #matches?' do
      expect(matcher.matches?(actual)).to be true
    end

    it 'returns correct negated failure message' do
      matcher.matches?(actual)
      expect(matcher.failure_message_when_negated).to eq(
        "expected that #{actual.to_s.inspect} would not match any of #{expected.inspect}, but it matched some."
      )
    end
  end
end
