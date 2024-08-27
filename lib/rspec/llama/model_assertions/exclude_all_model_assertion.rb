# frozen_string_literal: true

module RSpec
  module Llama
    class ExcludeAllModelAssertion < BaseModelAssertion
      private

      def passed?(result)
        values.all? { |value| !result.to_s.include?(value) }
      end
    end
  end
end
