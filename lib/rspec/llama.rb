# frozen_string_literal: true

require 'rspec'
require 'zeitwerk'

require_relative 'llama/version'

loader = Zeitwerk::Loader.for_gem
loader.push_dir("#{__dir__}/llama", namespace: RSpec::Llama)
loader.push_dir("#{__dir__}/llama/model_runners", namespace: RSpec::Llama)
loader.push_dir("#{__dir__}/llama/model_runner_results", namespace: RSpec::Llama)
loader.push_dir("#{__dir__}/llama/model_configurations", namespace: RSpec::Llama)
loader.push_dir("#{__dir__}/llama/model_assertions", namespace: RSpec::Llama)
loader.setup
