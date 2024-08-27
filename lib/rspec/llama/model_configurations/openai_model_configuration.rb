# frozen_string_literal: true

module RSpec
  module Llama
    class OpenaiModelConfiguration
      DEFAULT_MODEL = 'gpt-3.5-turbo'
      DEFAULT_TEMPERATURE = 0.5

      attr_reader :model, :temperature, :additional_options

      def initialize(model: DEFAULT_MODEL, temperature: DEFAULT_TEMPERATURE, **additional_options)
        @model = model
        @temperature = temperature
        @additional_options = additional_options
      end

      def to_h
        { model:, temperature:, **additional_options }.compact
      end
    end
  end
end
