# frozen_string_literal: true

module RSpec
  module Llama
    class OllamaModelConfiguration < BaseModelConfiguration
      DEFAULT_MODEL = 'llama3.1'

      attr_reader :model

      def initialize(model: DEFAULT_MODEL)
        @model = model
      end
    end
  end
end
