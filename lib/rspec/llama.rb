# frozen_string_literal: true

require 'rspec'

require_relative 'llama/version'
require_relative 'llama/helpers'

module RSpec
  module Llama
    # Model configurations
    autoload :BaseModelConfiguration, 'rspec/llama/model_configurations/base_model_configuration'
    autoload :OpenaiModelConfiguration, 'rspec/llama/model_configurations/openai_model_configuration'
    autoload :LlamaCppModelConfiguration, 'rspec/llama/model_configurations/llama_cpp_model_configuration'
    autoload :OllamaModelConfiguration, 'rspec/llama/model_configurations/ollama_model_configuration'

    # Model runners
    autoload :BaseModelRunner, 'rspec/llama/model_runners/base_model_runner'
    autoload :OpenaiModelRunner, 'rspec/llama/model_runners/openai_model_runner'
    autoload :LlamaCppModelRunner, 'rspec/llama/model_runners/llama_cpp_model_runner'
    autoload :OllamaModelRunner, 'rspec/llama/model_runners/ollama_model_runner'

    # Model prompt
    autoload :ModelPrompt, 'rspec/llama/model_prompt'

    # Model assertions
    autoload :BaseModelAssertion, 'rspec/llama/model_assertions/base_model_assertion'
    autoload :IncludeAllModelAssertion, 'rspec/llama/model_assertions/include_all_model_assertion'
    autoload :IncludeAnyModelAssertion, 'rspec/llama/model_assertions/include_any_model_assertion'
    autoload :ExcludeAllModelAssertion, 'rspec/llama/model_assertions/exclude_all_model_assertion'

    # Model assertion result
    autoload :ModelAssertionResult, 'rspec/llama/model_assertion_result'
  end
end
