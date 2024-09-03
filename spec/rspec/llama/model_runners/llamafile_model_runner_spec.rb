# frozen_string_literal: true

RSpec.describe RSpec::Llama::LlamafileModelRunner do
  subject(:call_runner!) { described_class.new(cli_path:).call(model_configuration, model_prompt) }

  let(:cli_path) { './llava-v1.5-7b-q4.llamafile' }
  let(:cli_options) { ['--cli', '--silent-prompt', '--temp', '0.1', '--seed', '20'] }
  let(:model_configuration) { instance_double(RSpec::Llama::LlamafileModelConfiguration, to_a: cli_options) }
  let(:model_prompt) { instance_double(RSpec::Llama::ModelPrompt, message: model_prompt_message) }
  let(:model_prompt_message) { 'Who created the Ruby language?' }
  let(:response) do
    'Matz, a Japanese computer programmer, created the Ruby programming language. He released the first ' \
      'version of Ruby in 1993, and it has since gained popularity as a versatile and easy-to-learn ' \
      'language for web development and other applications.'
  end

  describe '#call' do
    it 'runs the llamafile executable with the correct configuration and prompt', :aggregate_failures do
      allow(IO).to receive(:popen).and_yield(StringIO.new("\n\n#{response}\n"))

      result = call_runner!

      expect(result).to have_attributes(class: RSpec::Llama::LlamafileModelRunnerResult, to_s: response)
      expect(IO).to have_received(:popen).with([cli_path, '--prompt', model_prompt_message] + cli_options, 'r+')
    end
  end
end
