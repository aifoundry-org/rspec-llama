# frozen_string_literal: true

require 'rspec'

require_relative 'llama/version'
require_relative 'llama/helpers'
require_relative 'llama/matchers'

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
      BaseModelRunnerResult: 'rspec/llama/model_runner_results/base_model_runner_result',
      OpenaiModelRunnerResult: 'rspec/llama/model_runner_results/openai_model_runner_result',
      LlamaCppModelRunnerResult: 'rspec/llama/model_runner_results/llama_cpp_model_runner_result',
      OllamaModelRunnerResult: 'rspec/llama/model_runner_results/ollama_model_runner_result',

      # Model prompt
      ModelPrompt: 'rspec/llama/model_prompt',
    }.each { |class_name, path| autoload class_name, path }
  end
end

RSpec.configure do |config|
  config.include RSpec::Llama::Helpers
  config.include RSpec::Llama::Matchers
end
