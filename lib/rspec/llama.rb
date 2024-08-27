# frozen_string_literal: true

require 'rspec'

require_relative 'llama/version'
require_relative 'llama/helpers'

module RSpec
  module Llama
    {
      # Model configurations
      OpenaiModelConfiguration: 'rspec/llama/model_configurations/openai_model_configuration',
      LlamaCppModelConfiguration: 'rspec/llama/model_configurations/llama_cpp_model_configuration',
      OllamaModelConfiguration: 'rspec/llama/model_configurations/ollama_model_configuration',

      # Model runners
      OpenaiModelRunner: 'rspec/llama/model_runners/openai_model_runner',
      LlamaCppModelRunner: 'rspec/llama/model_runners/llama_cpp_model_runner',
      OllamaModelRunner: 'rspec/llama/model_runners/ollama_model_runner',

      # Model runner results
      OpenaiModelRunnerResult: 'rspec/llama/model_runner_results/openai_model_runner_result',
      LlamaCppModelRunnerResult: 'rspec/llama/model_runner_results/llama_cpp_model_runner_result',
      OllamaModelRunnerResult: 'rspec/llama/model_runner_results/ollama_model_runner_result',

      # Model prompt
      ModelPrompt: 'rspec/llama/model_prompt',

      # Model assertions
      BaseModelAssertion: 'rspec/llama/model_assertions/base_model_assertion',
      IncludeAllModelAssertion: 'rspec/llama/model_assertions/include_all_model_assertion',
      IncludeAnyModelAssertion: 'rspec/llama/model_assertions/include_any_model_assertion',
      ExcludeAllModelAssertion: 'rspec/llama/model_assertions/exclude_all_model_assertion',

      # Model assertion result
      ModelAssertionResult: 'rspec/llama/model_assertion_result'
    }.each do |class_name, path|
      autoload class_name, path
    end
  end
end
