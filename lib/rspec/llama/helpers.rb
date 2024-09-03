# frozen_string_literal: true

module RSpec
  module Llama
    module Helpers
      RUNNER_TYPES = {
        openai: 'OpenaiModelRunner',
        ollama: 'OllamaModelRunner',
        llama_cpp: 'LlamaCppModelRunner',
        llamafile: 'LlamafileModelRunner'
      }.freeze

      CONFIGURATION_TYPES = {
        openai: 'OpenaiModelConfiguration',
        ollama: 'OllamaModelConfiguration',
        llama_cpp: 'LlamaCppModelConfiguration',
        llamafile: 'LlamafileModelConfiguration'
      }.freeze

      ASSERTION_TYPES = {
        exclude_all: 'ExcludeAllModelAssertion',
        include_all: 'IncludeAllModelAssertion',
        include_any: 'IncludeAnyModelAssertion'
      }.freeze

      def build_model_configuration(configuration_type, **)
        configuration_class = CONFIGURATION_TYPES[configuration_type.to_sym]
        raise "Unsupported model configuration type: #{configuration_type}" unless configuration_class

        RSpec::Llama.const_get(configuration_class).new(**)
      end

      def build_model_runner(runner_type, **)
        runner_class = RUNNER_TYPES[runner_type.to_sym]
        raise "Unsupported model runner type: #{runner_type}" unless runner_class

        RSpec::Llama.const_get(runner_class).new(**)
      end
    end
  end
end
