# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelConfiguration
      DEFAULT_TEMPERATURE = 0.5
      DEFAULT_THREADS = 4
      DEFAULT_N_PREDICT = -1 # Generate until context is filled
      DEFAULT_STOP = /\A<(?:end|user|assistant|endoftext|system)>\z/

      attr_reader :model_path, :temperature, :threads, :n_predict, :additional_options

      def initialize(
        model_path:,
        temperature: DEFAULT_TEMPERATURE,
        threads: DEFAULT_THREADS,
        n_predict: DEFAULT_N_PREDICT,
        **additional_options
      )
        @model_path = model_path
        @temperature = temperature
        @threads = threads
        @n_predict = n_predict
        @additional_options = additional_options
      end

      def to_a
        cli_options = [
          '--model', @model_path,
          '--temp', @temperature.to_s,
          '--threads', @threads.to_s,
          '--predict', @n_predict.to_s
        ]

        # Add additional options in key-value pair format
        @additional_options.each do |option, value|
          if value == true
            cli_options << "--#{option}" # For flags
          else
            cli_options << "--#{option}" << value.to_s # For key-value pairs
          end
        end

        cli_options
      end
    end
  end
end
