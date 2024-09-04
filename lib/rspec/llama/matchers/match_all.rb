# frozen_string_literal: true

module RSpec
  module Llama
    module Matchers
      class MatchAll
        def initialize(*expected)
          @expected = expected
        end

        def matches?(actual)
          @actual = actual
          @unmatched_values = @expected.reject { |exp| @actual.to_s.match?(exp) }

          @unmatched_values.empty?
        end

        def failure_message
          "expected that #{@actual.to_s.inspect} would match all of #{@expected.inspect}, " \
            "but it did not match: #{@unmatched_values.inspect}"
        end

        def failure_message_when_negated
          "expected that #{@actual.to_s.inspect} would not match all of #{@expected.inspect}, but it matched all."
        end
      end
    end
  end
end
