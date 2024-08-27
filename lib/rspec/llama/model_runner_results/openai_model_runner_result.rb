# frozen_string_literal: true

module RSpec
  module Llama
    class OpenaiModelRunnerResult
      MESSAGE_PATH = [:choices, 0, :message, :content].freeze

      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        response.dig(*MESSAGE_PATH)
      end
    end
  end
end
