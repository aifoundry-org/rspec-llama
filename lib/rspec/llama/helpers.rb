# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      def execute_test_run(test_id)
        Rspec::Llama.api_client.execute_test_run(test_id)
      end
    end
  end
end
