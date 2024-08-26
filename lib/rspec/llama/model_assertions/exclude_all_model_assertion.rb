# frozen_string_literal: true

module RSpec
  module Llama
    class ExcludeAllModelAssertion < BaseModelAssertion
      private

      def passed?(result)
        values.all? { |value| !result&.include?(value) }
      end
    end
  end
end
