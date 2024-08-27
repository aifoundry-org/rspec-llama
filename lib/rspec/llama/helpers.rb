# frozen_string_literal: true

module RSpec
  module Llama
    module Helpers
      RUNNER_TYPES = {
        openai: 'OpenaiModelRunner',
        ollama: 'OllamaModelRunner',
        llama_cpp: 'LlamaCppModelRunner'
      }.freeze

      CONFIGURATION_TYPES = {
        openai: 'OpenaiModelConfiguration',
        ollama: 'OllamaModelConfiguration',
        llama_cpp: 'LlamaCppModelConfiguration'
      }.freeze

      ASSERTION_TYPES = {
        exclude_all: 'ExcludeAllModelAssertion',
        include_all: 'IncludeAllModelAssertion',
        include_any: 'IncludeAnyModelAssertion',
        model_version: 'ModelVersionModelAssertion'
      }.freeze

      def build_model_prompt(message)
        ModelPrompt.new(message)
      end

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

      def build_model_assertion(assertion_type, value, *other_values)
        assertion_class = ASSERTION_TYPES[assertion_type.to_sym]
        raise "Unsupported assertion type: #{assertion_type}" unless assertion_class

        RSpec::Llama.const_get(assertion_class).new(value, *other_values)
      end
    end
  end
end
