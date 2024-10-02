# frozen_string_literal: true

module RSpec
  module Llama
    class LlamaCppModelRunnerResult < BaseModelRunnerResult
      def to_s
        response.strip
      end
    end
  end
end
