# frozen_string_literal: true

require 'rspec'

require_relative 'llama/version'
require_relative 'llama/helpers'

module RSpec
  module Llama
    { model_configurations: %i[OpenaiModelConfiguration LlamaCppModelConfiguration OllamaModelConfiguration],
      model_runners: %i[OpenaiModelRunner LlamaCppModelRunner OllamaModelRunner],
      model_runner_results: %i[OpenaiModelRunnerResult LlamaCppModelRunnerResult OllamaModelRunnerResult],
      model_assertions: %i[BaseModelAssertion IncludeAllModelAssertion IncludeAnyModelAssertion
                           ExcludeAllModelAssertion] }.each do |type, classes|
      classes.each do |class_name|
        autoload class_name, "rspec/llama/#{type}/#{class_name.to_s.gsub(/([A-Z])/, '_\1').downcase.sub(/^_/, '')}"
      end
    end
    autoload :ModelPrompt, 'rspec/llama/model_prompt'
    autoload :ModelAssertionResult, 'rspec/llama/model_assertion_result'
  end
end

RSpec.configure do |config|
  config.include RSpec::Llama::Helpers
end
