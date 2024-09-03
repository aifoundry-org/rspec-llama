# frozen_string_literal: true

module RSpec
  module Llama
    class LlamafileModelConfiguration
      DEFAULT_TEMPERATURE = 0.5
      DEFAULT_PREDICT = 500

      attr_reader :temperature, :predict, :additional_options

      # Initializes a new configuration for the llamafile model.
      #
      # @param [Float] temperature The temperature for sampling, between 0 and 2. Higher values
      #   make the output more random, while lower values make it more focused. Defaults to 0.5.
      # @param [Integer] predict The number of tokens to predict. Defaults to 500.
      #   that matches common end-of-text tokens.
      # @param [Hash] additional_options Additional configuration options, where keys are the option names and values
      #   are either true (for flags) or values for key-value pairs. These options are passed directly to the CLI.
      #
      # @example Basic usage with a specific model path and default parameters
      #   config = RSpec::Llama::LlamafileModelConfiguration.new
      #
      # @example Custom parameters and additional CLI options
      #   config = RSpec::Llama::LlamafileModelConfiguration.new(
      #     temperature: 0.7, predict: 300, threads: 8
      #   )
      def initialize(
        temperature: DEFAULT_TEMPERATURE,
        predict: DEFAULT_PREDICT,
        **additional_options
      )
        @temperature = temperature
        @predict = predict
        @additional_options = additional_options
      end

      # Converts the configuration into an array of CLI options.
      #
      # @return [Array<String>] An array of strings representing CLI options, where each key-value
      #   pair or flag is converted to the appropriate format for passing to the executable.
      #
      # @example CLI options
      #   config.to_a
      #   # => ['--cli', '--silent-prompt', '--temp', '0.7', '--n-predict', '500']
      def to_a
        cli_options = [
          '--cli', '--silent-prompt', '--log-disable', '--temp', temperature.to_s, '--n-predict', predict.to_s
        ]

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
