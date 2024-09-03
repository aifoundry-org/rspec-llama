# frozen_string_literal: true

module RSpec
  module Llama
    class LlamafileModelRunner
      attr_reader :cli_path

      def initialize(cli_path:)
        @cli_path = cli_path
      end

      # Runs the model with the given configuration and prompt.
      #
      # @param [RSpec::Llama::LlamafileModelConfiguration] configuration
      # @param [String] prompt
      #
      # @return [RSpec::Llama::LlamafileModelRunnerResult]
      def call(configuration, prompt)
        command = [cli_path, '--prompt', prompt.to_s] + configuration.to_a

        IO.popen(command, 'r+') do |io|
          LlamafileModelRunnerResult.new(io.read)
        end
      end
    end
  end
end
