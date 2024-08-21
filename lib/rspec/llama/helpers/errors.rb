# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      module Errors

        class BaseResourceError < StandardError
          attr_reader :resource, :name
          def initialize(resource, name, message)
            @resource = resource
            @name = name
            super(message)
          end
        end

        class ResourceAlreadyCreated < BaseResourceError
          def initialize(resource, name)
            msg = "#{resource.to_s.capitalize} with name #{name} has already been created"
            super(resource, name, msg)
          end
        end

        class ResourceNotFound < BaseResourceError
          def initialize(resource, name)
            msg = "#{resource.to_s.capitalize} with name #{name} not found"
            super(resource, name, msg)
          end
        end

        class ResourceFailedToCreate < BaseResourceError
          def initialize(resource, name)
            msg = "Failed to create #{resource.to_s.capitalize} with name #{name}"
            super(resource, name, msg)
          end
        end

        class TestRunExecutionError < StandardError
          def initialize(test_run)
            msg = test_run.map { |k, v| "#{k.singularize} #{v.last}" }.join(', ')
            super(msg)
          end
        end
      end
    end
  end
end
