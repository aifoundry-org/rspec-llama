# frozen_string_literal: true

module RSpec
  module Llama
    class IncludeAnyModelAssertion < BaseModelAssertion
      private

      def passed?(result)
        values.any? { |value| result.to_s.include?(value) }
      end
    end
  end
end
