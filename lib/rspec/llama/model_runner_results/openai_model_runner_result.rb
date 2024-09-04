# frozen_string_literal: true

module RSpec
  module Llama
    class OpenaiModelRunnerResult < BaseModelRunnerResult
      MESSAGE_PATH = [:choices, 0, :message, :content].freeze

      def to_s
        response.dig(*MESSAGE_PATH)
      end
    end
  end
end
