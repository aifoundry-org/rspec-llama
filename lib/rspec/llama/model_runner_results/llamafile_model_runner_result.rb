# frozen_string_literal: true

module RSpec
  module Llama
    class LlamafileModelRunnerResult
      attr_reader :result

      def initialize(result)
        @result = result
      end

      def to_s
        result.strip
      end
    end
  end
end
