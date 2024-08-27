# frozen_string_literal: true

module RSpec
  module Llama
    class OpenaiModelConfiguration
      DEFAULT_MODEL = 'gpt-3.5-turbo'
      DEFAULT_TEMPERATURE = 0.5

      attr_reader :model, :temperature, :additional_options

      # Initializes a new configuration for the OpenAI model.
      #
      # @param [String] model The model to use. Defaults to 'gpt-3.5-turbo'.
      # @param [Float] temperature The sampling temperature for the model, between 0 and 2.0.
      #   Higher values make output more random, while lower values make it more focused. Defaults to 0.5.
      # @param [Hash] additional_options Additional configuration options to pass to the API, such as
      #   max_tokens, top_p, stop, and others. This allows flexibility for adding any supported parameters
      #   without modifying the class. The keys should be symbols.
      #
      # @example Basic usage with default model and temperature
      #   config = RSpec::Llama::OpenaiModelConfiguration.new
      #
      # @example Passing custom options
      #   config = RSpec::Llama::OpenaiModelConfiguration.new(
      #     model: 'gpt-4',
      #     temperature: 0.8,
      #     max_tokens: 150,
      #     stop: ['\n']
      #   )
      #
      # @see https://platform.openai.com/docs/api-reference/chat/create
      def initialize(model: DEFAULT_MODEL, temperature: DEFAULT_TEMPERATURE, **additional_options)
        @model = model
        @temperature = temperature
        @additional_options = additional_options
      end

      # Converts the configuration into a hash format for making API requests.
      #
      # @return [Hash] A hash representation of the model configuration.
      #   This hash includes the model, temperature, and any additional options provided during initialization.
      #   Nil values are omitted from the hash.
      def to_h
        { model:, temperature:, **additional_options }.compact
      end
    end
  end
end
