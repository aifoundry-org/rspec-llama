# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelConfiguration
      DEFAULT_TEMPERATURE = 0.5
      DEFAULT_N_PREDICT = 500
      DEFAULT_STOP = ['<|end|>', '<|user|>', '<|assistant|>', '<|endoftext|>', '<|system|>'].freeze

      attr_reader :temperature, :n_predict, :stop

      def initialize(temperature: DEFAULT_TEMPERATURE, n_predict: DEFAULT_N_PREDICT, stop: DEFAULT_STOP)
        @temperature = temperature
        @n_predict = n_predict
        @stop = stop
      end
    end
  end
end
