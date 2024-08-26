# frozen_string_literal: true

module RSpec
  module Llama
    class IncludeAnyModelAssertion < BaseModelAssertion
      private

      def passed?(result)
        values.any? { |value| result&.include?(value) }
      end
    end
  end
end
