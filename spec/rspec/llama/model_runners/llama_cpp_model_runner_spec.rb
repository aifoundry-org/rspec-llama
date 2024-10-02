# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamaCppModelRunner do
  subject(:call_runner!) { described_class.new(cli_path:).call(model_configuration, model_prompt) }

  let(:cli_path) { 'llama-cli' }
  let(:cli_options) { ['--model', '/path/to/model', '--temp', '0.5', '--threads', '4', '--predict', '-1'] }
  let(:model_configuration) { instance_double(RSpec::Llama::LlamaCppModelConfiguration, to_a: cli_options) }
  let(:model_prompt) { 'Tell me about Ruby programming' }

  describe '#call' do
    it 'runs the llama-cli executable with the correct configuration and prompt', :aggregate_failures do
      allow(IO).to receive(:popen).and_yield(StringIO.new('Ruby is a dynamic language'))

      result = call_runner!

      expect(result).to have_attributes(
        class: RSpec::Llama::LlamaCppModelRunnerResult,
        to_s: 'Ruby is a dynamic language'
      )

      expect(IO).to have_received(:popen).with(
        [cli_path, '--prompt', 'Tell me about Ruby programming'] + cli_options, 'r+'
      )
    end
  end
end
