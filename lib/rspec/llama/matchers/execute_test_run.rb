# frozen_string_literal: true

module Rspec
  module Llama
    RSpec::Matchers.define :execute_test_run do |test_id|
      match do |expected|
        result = Rspec::Llama.api_client.execute_test_run(test_id)
        result['success'] == expected
      end

      failure_message do |expected|
        "expected that API test run with ID #{test_id} would return #{expected}"
      end

      failure_message_when_negated do |expected|
        "expected that API test run with ID #{test_id} would not return #{expected}"
      end
    end
  end
end
