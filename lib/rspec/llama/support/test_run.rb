# frozen_string_literal: true

module Rspec
  module Llama
    module Support
      TestRun = Struct.new(:id, :name, :test_result_ids) do
        def latest_test_result
          test_result_ids.map { |id| Rspec::Llama.api_client.fetch_test_result(id) }.last
        end

        def latest_assertion_result
          Rspec::Llama.api_client.fetch_assertion_results(latest_test_result['id']).last
        end

        def successful?
          latest_assertion_result['state'] == 'passed'
        end

        def failed?
          latest_assertion_result['state'] == 'failed'
        end
      end
    end
  end
end

