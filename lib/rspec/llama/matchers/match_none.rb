# frozen_string_literal: true

module RSpec
  module Llama
    module Matchers
      class MatchNone
        def initialize(*expected)
          @expected = expected
        end

        def description
          "match none of #{@expected.inspect}"
        end

        def matches?(actual)
          @actual = actual
          @matched_values = @expected.select { |exp| @actual.to_s.match?(exp) }

          @matched_values.empty?
        end

        def failure_message
          "expected #{@actual.to_s.inspect} to match none of #{@expected.inspect}, " \
            "but it matched: #{@matched_values.inspect}"
        end

        def failure_message_when_negated
          "expected #{@actual.to_s.inspect} to match at least one of #{@expected.inspect}, but none matched."
        end
      end
    end
  end
end
