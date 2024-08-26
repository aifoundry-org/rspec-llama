# frozen_string_literal: true

module RSpec
  module Llama
    class BaseModelAssertion
      attr_reader :values

      # @param [String] value
      # @param [Array<String>] other_values
      def initialize(value, *other_values)
        @values = [value, *other_values]
      end

      # @param [String] result
      def call(result)
        ModelAssertionResult.new(passed?(result))
      end

      private

      def passed?(result)
        raise NotImplementedError
      end
    end
  end
end
