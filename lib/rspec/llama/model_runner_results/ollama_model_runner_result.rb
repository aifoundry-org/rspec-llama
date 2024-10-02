# frozen_string_literal: true

module RSpec
  module Llama
    class OllamaModelRunnerResult < BaseModelRunnerResult
      def to_s
        response
      end
    end
  end
end
