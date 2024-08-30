# frozen_string_literal: true

# stub: rspec-llama 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = 'rspec-llama'
  s.version = '0.1.0'

  s.metadata = { 'rubygems_mfa_required' => 'true' }
  s.authors = ['Vadser']
  s.bindir = 'exe'
  s.description = <<~DESC
    RSpec::Llama is a testing framework that allows developers to easily configure, run, and validate
    AI models such as OpenAI's GPT models, Llama, and others within the RSpec ecosystem.

    With a focus on simplicity and extensibility, RSpec::Llama provides:
    - A standardized approach to configuring different AI models with customizable parameters.
    - Runners to execute model interactions and capture responses seamlessly.
    - Comprehensive assertion types to validate model outputs against expected patterns.

    Whether you are developing AI-powered applications or simply need a reliable way to test various AI
    models' outputs, RSpec::Llama offers an all-in-one solution that integrates smoothly into your existing RSpec setup.
  DESC
  s.email = ['vadser1999@gmail.com']
  s.files = Dir['CODE_OF_CONDUCT.md', 'LICENSE', 'README.md', 'lib/**/*.rb']
  s.homepage = 'https://github.com/aifoundry-org/rspec-llama'
  s.license = 'Apache-2.0'
  s.required_ruby_version = '>= 3.2'
  s.summary = 'A versatile testing framework for different AI model configurations.'

  s.add_dependency('rspec', '~> 3.0')
end
