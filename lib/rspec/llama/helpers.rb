# frozen_string_literal: true

require_relative 'helpers/resource_handler'
require_relative 'helpers/executor'

module Rspec
  module Llama
    module Helpers
      include ResourceHandler
      include Executor
    end
  end
end
