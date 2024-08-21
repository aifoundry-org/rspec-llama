# frozen_string_literal: true

module Rspec
  module Llama
    module Helpers
      module Base

        def fetch_resource_with_error_handling(resource, *args, &block)
          key = (resource == :model_version ? 'build_name' : 'name')
          name = args.delete_at(0)

          resource_obj = if block_given?
                           yield
                         else
                           resources = Rspec::Llama.api_client.public_send("fetch_all_#{resource.to_s.pluralize}", *args)
                           resources.find { |r| r[key] == name }
                         end
          raise Errors::ResourceNotFound.new(resource, name) unless resource_obj

          instance_variable_set("@#{resource}", resource_obj)
        rescue StandardError => e
          raise e
        end

        def create_resource_with_error_handling(resource, args)
          resource_obj = Rspec::Llama.api_client.public_send("create_#{resource}", args) || {}
          resource_obj = if resource_obj['name'].is_a?(Array)
                           resource_obj['name'].last
                         else
                           resource_obj
                         end

          raise Errors::ResourceFailedToCreate.new(resource, args[:name]) if resource_obj.blank?
          raise Errors::ResourceAlreadyCreated.new(resource, args[:name]) if resource_obj == "has already been taken"

          instance_variable_set("@#{resource}", resource_obj)
        rescue Errors::ResourceAlreadyCreated => e
          fetch_resource_with_error_handling(e.resource, e.name)
        rescue StandardError => e
          raise e
        end
      end
    end
  end
end

