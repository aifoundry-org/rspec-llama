# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      module ResourceHandler

        def use_model(name, version = nil)
          models = Rspec::Llama.api_client.fetch_all_models
          @model = models.find { |m| m['name'] == name }
          use_model_version(@model['id'], version) if version
        end

        def use_model_version(model_id, version)
          model_versions = Rspec::Llama.api_client.fetch_all_model_versions(model_id)
          @model_version = model_versions.find { |mv| mv['build_name'] == version }
        end

        def use_prompt(name)
          prompts = Rspec::Llama.api_client.fetch_all_prompts
          @prompt = prompts.find { |p| p['name'] == name }
        end

        def use_assertion(name)
          assertions = Rspec::Llama.api_client.fetch_all_assertions
          @assertion = assertions.find { |a| a['name'] == name }
        end

        def use_test_run(test_run_id)
          @test_run = Rspec::Llama.api_client.fetch_test_run(test_run_id)
        end

        def use_test_model_version_run(test_model_version_run_id)
          @model_version_run = Rspec::Llama.api_client.fetch_test_model_version_run(test_model_version_run_id)
        end

        def create_model(name, version = nil)
          @model = Rspec::Llama.api_client.create_model(name: name, url: 'http://host.docker.internal:8000/completion')
          use_model_version(@model['id'], version) if version
          @model_version.nil? ? create_model_version(@model['id'], version) : @model_version
        end

        def create_model_version(model_id, name)
          opts = { model_version: { configuration: { n_predict: 100, temperature: 0.8 }.to_json, description: '', built_on: Date.today, build_name: name } }
          @model_version = Rspec::Llama.api_client.create_model_version(model_id, opts)
        end

        def create_prompt(name, prompt, model = settled_model)
          @prompt = Rspec::Llama.api_client.create_prompt(model['id'], name: name, value: prompt)
        end

        def create_assertion(name, value, assertion_type = 'exclude', model = settled_model)
          @assertion = Rspec::Llama.api_client.create_assertion(model, name: name, assertion_type: assertion_type, value: value)
        end

        def fetch_test_results(test_run_id)
          test_result_ids = Rspec::Llama.api_client.fetch_test_run(test_run_id)['test_result_ids']
          @test_results = test_result_ids.map { |id| Rspec::Llama.api_client.fetch_test_result(id) }
        end

        def fetch_assertion_results(test_result_id)
          @assertion_results = Rspec::Llama.api_client.fetch_assertion_results(test_result_id)
        end

        %i[model prompt assertion model_version test_run test_results assertion_results].each do |method|
          define_method("settled_#{method}") do |*args|
            instance_variable_get("@#{method}").nil? ? raise("#{method} not settled") : instance_variable_get("@#{method}")
          end
        end
      end
    end
  end
end



