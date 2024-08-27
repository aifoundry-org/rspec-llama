# frozen_string_literal: true

module RSpec
  module Llama
    class ModelAssertionResult
      def initialize(passed)
        @passed = !!passed
      end

      def passed?
        @passed
      end

      def failed?
        !passed?
      end
    end
  end
end
