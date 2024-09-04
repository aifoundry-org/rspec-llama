# frozen_string_literal: true

module RSpec
  module Llama
    class BaseModelRunnerResult
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        raise NotImplementedError
      end
    end
  end
end
