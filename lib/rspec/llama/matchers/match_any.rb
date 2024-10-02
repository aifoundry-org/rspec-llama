# frozen_string_literal: true

module RSpec
  module Llama
    module Matchers
      class MatchAny
        def initialize(*expected)
          @expected = expected
        end

        def description
          "match any of #{@expected.inspect}"
        end

        def matches?(actual)
          @actual = actual
          @unmatched_values = @expected.reject { |exp| @actual.to_s.match?(exp) }

          @unmatched_values.size < @expected.size
        end

        def failure_message
          "expected #{@actual.to_s.inspect} to match any of #{@expected.inspect}, but none of them matched."
        end

        def failure_message_when_negated
          "expected #{@actual.to_s.inspect} not to match any of #{@expected.inspect}, but it matched some."
        end
      end
    end
  end
end
