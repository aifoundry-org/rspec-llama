# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      module ResourceHandler

        def use_model(model_name, version_name)
          fetch_model(model_name)
          fetch_model_version(version_name, settled_model['id'])
        end

        def use_prompt(name)
          fetch_prompt(name)
        end

        def use_assertion(name)
          fetch_assertion(name)
        end

        def build_prompt(name, prompt)
          opts = { name: name, value: prompt, model_id: settled_model['id'] }
          create_prompt(opts)
        end

        def build_assertion(name, value, assertion_type = 'exclude_all')
          opts = { name: name, value: value, assertion_type: assertion_type, model_id: settled_model['id'] }
          create_assertion(opts)
        end

        def retrieve_test_run(test_run_id)
          test_run = fetch_test_run(test_run_id) do
            Rspec::Llama.api_client.fetch_test_run(test_run_id)
          end
        end

        def retrieve_test_model_version_run(test_model_version_run_id)
          fetch_test_model_version_run(test_model_version_run_id) do
            Rspec::Llama.api_client.fetch_test_model_version_run(test_model_version_run_id)
          end
        end

        def retrieve_test_results(test_run_id)
          fetch_test_results(test_run_id) do
            test_result_ids = retrieve_test_run(test_run_id)['test_result_ids']
            test_result_ids.map { |id| Rspec::Llama.api_client.fetch_test_result(id) }
          end
        end

        def retrieve_assertion_results(test_result_id)
          fetch_assertion_results(test_result_id) do
            Rspec::Llama.api_client.fetch_assertion_results(test_result_id)
          end
        end

        def test_run
          Support::TestRun.new(settled_test_run['id'], settled_test_run['name'], settled_test_run['test_result_ids'])
        end

        %i[model prompt assertion model_version test_run test_results assertion_results].each do |method|
          define_method("settled_#{method}") do |*_args|
            instance_variable_get("@#{method}").nil? ? raise("#{method} not settled") : instance_variable_get("@#{method}")
          end
        end

        private

        %i[model model_version prompt assertion test_run test_model_version_run test_results
           assertion_results].each do |method|
          define_method("fetch_#{method}") do |*args, &block|
            fetch_resource_with_error_handling(method, *args, &block)
          end
        end

        %i[prompt assertion].each do |method|
          define_method("create_#{method}") do |args|
            create_resource_with_error_handling(method, args)
          end
        end
      end
    end
  end
end
