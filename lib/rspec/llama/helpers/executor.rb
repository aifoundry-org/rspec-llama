# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      module Executor

        def execute_test_run(prompt_id: nil, assertion_id: nil, model_version_id: nil)
          prompt_id ||= settled_prompt['id']
          assertion_id ||= settled_assertion['id']
          model_version_id ||= settled_model_version['id']

          opts = prepare_test_run_data(prompt_id, assertion_id, model_version_id)
          test_run = Rspec::Llama.api_client.execute_test_run(opts)
          validate_test_run!(test_run)

          test_run_waiter(test_run['id'])
        end

        private

        def test_run_waiter(test_run_id)
          is_completed = false
          is_failed = false

          spinner_thread = Thread.new do
            spinner = %w[| / - \\]
            while !is_completed
              spinner.each do |frame|
                print "\r  Processing...#{frame}"
                sleep(0.2)
              end
            end
            print "\r" and $stdout.flush
          end

          loop do
            test_results = retrieve_test_results(test_run_id)
            is_completed = !test_results.empty? && test_results.all? { |result| result['status'] == 'completed' }
            retrieve_assertion_results(test_results.last['id']) if is_completed

            break if is_completed

            sleep 1
          end

          spinner_thread.join
        end

        def test_run_name
          "rspec_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}"
        end

        def validate_test_run!(test_run)
          raise Errors::TestRunExecutionError.new(test_run) unless test_run&.[]('id')
        end

        def prepare_test_run_data(prompt_id, assertion_id, model_version_id)
          opts = Hash.new { |hash, key| hash[key] = {} }
          opts[:test_run][:name] = test_run_name
          opts[:test_run][:prompt_id] = prompt_id
          opts[:test_run][:calls] = 1
          opts[:test_run][:passing_threshold] = 0.5
          opts[:test_run][:assertion_ids] = [assertion_id]
          opts[:test_run][:model_version_ids] = [model_version_id]

          opts
        end
      end
    end
  end
end
