# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelConfiguration
      DEFAULT_TEMPERATURE = 0.5
      DEFAULT_PREDICT = 500
      DEFAULT_STOP = /\A<(?:end|user|assistant|endoftext|system)>\z/

      attr_reader :model, :temperature, :predict, :stop, :additional_options

      # Initializes a new configuration for the llama.cpp model.
      #
      # @param [String] model The path to the model file that will be used.
      # @param [Float] temperature The temperature for sampling, between 0 and 2. Higher values
      #   make the output more random, while lower values make it more focused. Defaults to 0.5.
      # @param [Integer] predict The number of tokens to predict. Defaults to 500.
      # @param [Regexp] stop The stop token that signals the end of generation. Defaults to a regular expression
      #   that matches common end-of-text tokens.
      # @param [Hash] additional_options Additional configuration options, where keys are the option names and values
      #   are either true (for flags) or values for key-value pairs. These options are passed directly to the CLI.
      #
      # @example Basic usage with a specific model path and default parameters
      #   config = RSpec::Llama::LlamaCppModelConfiguration.new(
      #     model: '/path/to/model'
      #   )
      #
      # @example Custom parameters and additional CLI options
      #   config = RSpec::Llama::LlamaCppModelConfiguration.new(
      #     model: '/path/to/model',
      #     temperature: 0.7,
      #     predict: 300,
      #     threads: 8,
      #     verbose: true,
      #     log_file: '/path/to/logfile'
      #   )
      def initialize(
        model:,
        temperature: DEFAULT_TEMPERATURE,
        predict: DEFAULT_PREDICT,
        stop: DEFAULT_STOP,
        **additional_options
      )
        @model = model
        @temperature = temperature
        @predict = predict
        @stop = stop
        @additional_options = additional_options
      end

      # Converts the configuration into an array of CLI options.
      #
      # @return [Array<String>] An array of strings representing CLI options, where each key-value
      #   pair or flag is converted to the appropriate format for passing to the llama.cpp executable.
      #
      # @example CLI options
      #   config.to_a
      #   # => ['--model', '/path/to/model', '--temp', '0.7', '--verbose', '--log-file', '/path/to/logfile']
      def to_a
        cli_options = ['--model', model, '--temp', temperature.to_s, '--predict', predict.to_s]

        # Add additional options in key-value pair format
        additional_options.each do |option, value|
          cli_options << "--#{option}".tr('_', '-')
          cli_options << value.to_s unless value == true
        end

        cli_options
      end
    end
  end
end
