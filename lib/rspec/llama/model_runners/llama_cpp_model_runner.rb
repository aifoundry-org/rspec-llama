# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelRunner
      DEFAULT_CLI_PATH = 'llama-cli'

      attr_reader :cli_path

      def initialize(cli_path: DEFAULT_CLI_PATH)
        @cli_path = cli_path
      end

      # @param [RSpec::Llama::LlamaCppModelConfiguration] configuration
      # @param [RSpec::Llama::ModelPrompt] prompt
      # @return [RSpec::Llama::LlamaCppModelRunnerResult]
      def call(configuration, prompt)
        command = [cli_path, '--prompt', prompt.message] + configuration.to_a

        IO.popen(command, 'r+') do |io|
          LlamaCppModelRunnerResult.new(io.read)
        end
      end
    end
  end
end
