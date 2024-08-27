# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelRunnerResult
      attr_reader :result

      def initialize(result)
        @result = result
      end

      def to_s
        result.strip # Removes any leading/trailing whitespace or newlines
      end
    end
  end
end
