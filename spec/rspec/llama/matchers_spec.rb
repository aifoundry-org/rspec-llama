# frozen_string_literal: true

RSpec.describe RSpec::Llama::Matchers do
  subject(:matchers) { Class.new { include RSpec::Llama::Matchers }.new }

  describe '#match' do
    let(:expected) { 'foo' }
    let(:matcher) { instance_double(RSpec::Llama::Matchers::Match) }

    it 'creates an instance of the Match matcher' do
      allow(RSpec::Llama::Matchers::Match).to receive(:new).with(expected).and_return(matcher)
      expect(matchers.match(expected)).to eq(matcher)
    end
  end

  describe '#match_all' do
    let(:expected) { ['foo', 'bar'] }
    let(:matcher) { instance_double(RSpec::Llama::Matchers::MatchAll) }

    it 'creates an instance of the MatchAll matcher' do
      allow(RSpec::Llama::Matchers::MatchAll).to receive(:new).with(*expected).and_return(matcher)
      expect(matchers.match_all(*expected)).to eq(matcher)
    end
  end

  describe '#match_any' do
    let(:expected) { ['foo', 'bar'] }
    let(:matcher) { instance_double(RSpec::Llama::Matchers::MatchAny) }

    it 'creates an instance of the MatchAny matcher' do
      allow(RSpec::Llama::Matchers::MatchAny).to receive(:new).with(*expected).and_return(matcher)
      expect(matchers.match_any(*expected)).to eq(matcher)
    end
  end

  describe '#match_none' do
    let(:expected) { ['foo', 'bar'] }
    let(:matcher) { instance_double(RSpec::Llama::Matchers::MatchNone) }

    it 'creates an instance of the MatchNone matcher' do
      allow(RSpec::Llama::Matchers::MatchNone).to receive(:new).with(*expected).and_return(matcher)
      expect(matchers.match_none(*expected)).to eq(matcher)
    end
  end
end
