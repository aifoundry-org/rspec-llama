# frozen_string_literal: true

module RSpec
  module Llama
    module Matchers
      class Match < RSpec::Matchers::BuiltIn::Match
        def matches?(actual)
          return super unless actual.is_a?(RSpec::Llama::BaseModelRunnerResult)

          @actual = actual
          @actual.to_s.match?(@expected)
        end

        def failure_message
          return super unless @actual.is_a?(RSpec::Llama::BaseModelRunnerResult)

          "expected #{@actual.to_s.inspect} to match #{@expected.inspect}"
        end

        def failure_message_when_negated
          return super unless @actual.is_a?(RSpec::Llama::BaseModelRunnerResult)

          "expected #{@actual.to_s.inspect} not to match #{@expected.inspect}"
        end
      end
    end
  end
end
