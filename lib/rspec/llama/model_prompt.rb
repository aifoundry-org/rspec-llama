# frozen_string_literal: true

module RSpec
  module Llama
    class ModelPrompt
      attr_reader :messages

      def initialize(*messages)
        @messages = messages
      end
    end
  end
end
