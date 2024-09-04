# frozen_string_literal: true

RSpec.describe RSpec::Llama::Matchers::Match do
  subject(:matcher) { described_class.new(expected) }

  let(:actual) { instance_double(RSpec::Llama::BaseModelRunnerResult, to_s: 'This result contains foo and bar') }

  before do
    allow(actual).to receive(:is_a?).with(RSpec::Llama::BaseModelRunnerResult).and_return(true)
  end

  context 'with strings' do
    context 'when the actual string matches the expected string' do
      let(:expected) { 'foo' }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns the correct failure message when negated' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.to_s.inspect} not to match #{expected.inspect}"
        )
      end
    end

    context 'when the actual string does not match the expected string' do
      let(:expected) { 'baz' }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns the correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.to_s.inspect} to match #{expected.inspect}"
        )
      end
    end
  end

  context 'with regular expressions' do
    context 'when the actual string matches the expected pattern' do
      let(:expected) { /foo/ }

      it 'returns true for #matches?' do
        expect(matcher.matches?(actual)).to be true
      end

      it 'returns the correct failure message when negated' do
        matcher.matches?(actual)
        expect(matcher.failure_message_when_negated).to eq(
          "expected #{actual.to_s.inspect} not to match #{expected.inspect}"
        )
      end
    end

    context 'when the actual string does not match the expected pattern' do
      let(:expected) { /baz/ }

      it 'returns false for #matches?' do
        expect(matcher.matches?(actual)).to be false
      end

      it 'returns the correct failure message' do
        matcher.matches?(actual)
        expect(matcher.failure_message).to eq(
          "expected #{actual.to_s.inspect} to match #{expected.inspect}"
        )
      end
    end
  end
end
