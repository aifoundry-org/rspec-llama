# frozen_string_literal: true

module RSpec
  module Llama
    class OpenaiModelConfiguration < BaseModelConfiguration
      DEFAULT_MODEL = 'gpt-3.5-turbo'
      DEFAULT_TEMPERATURE = 0.5

      attr_reader :model, :temperature

      def initialize(model: DEFAULT_MODEL, temperature: DEFAULT_TEMPERATURE)
        @model = model
        @temperature = temperature
      end

      def to_h
        { model:, temperature: }
      end
    end
  end
end
