# frozen_string_literal: true

module RSpec
  module Llama
    module Matchers
      {
        Match: 'rspec/llama/matchers/match',
        MatchAll: 'rspec/llama/matchers/match_all',
        MatchAny: 'rspec/llama/matchers/match_any',
        MatchNone: 'rspec/llama/matchers/match_none'
      }.each { |class_name, path| autoload class_name, path }

      def match(expected)
        Match.new(expected)
      end

      def match_all(*expected)
        MatchAll.new(*expected)
      end

      def match_any(*expected)
        MatchAny.new(*expected)
      end

      def match_none(*expected)
        MatchNone.new(*expected)
      end
    end
  end
end
