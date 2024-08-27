# frozen_string_literal: true

module RSpec
  module Llama
    class ModelPrompt
      attr_reader :message

      def initialize(message)
        @message = message
      end
    end
  end
end
