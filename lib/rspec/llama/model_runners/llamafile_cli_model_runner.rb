# frozen_string_literal: true

module RSpec
  module Llama
    class LlamafileCliModelRunner
      attr_reader :path

      def initialize(path:)
        @path = path
      end

      # Runs the model with the given configuration and prompt.
      #
      # @param [RSpec::Llama::LlamafileCliModelConfiguration] configuration
      # @param [RSpec::Llama::ModelPrompt] prompt
      #
      # @return [RSpec::Llama::LlamafileCliModelRunnerResult]
      def call(configuration, prompt)
        command = [path, '--prompt', prompt.message] + configuration.to_a

        IO.popen(command, 'r+') do |io|
          LlamafileCliModelRunnerResult.new(io.read)
        end
      end
    end
  end
end
