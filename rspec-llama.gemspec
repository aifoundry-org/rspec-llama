# frozen_string_literal: true

# stub: rspec-llama 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = 'rspec-llama'
  s.version = '0.1.0'

  s.metadata = { 'rubygems_mfa_required' => 'true' }
  s.authors = ['Vadser']
  s.bindir = 'exe'
  s.description = 'Write a longer description or delete this line.'
  s.email = ['vadser1999@gmail.com']
  s.files = Dir['CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*.rb']
  s.homepage = 'https://example.com'
  s.licenses = ['MIT']
  s.required_ruby_version = '>= 3.2'
  s.summary = 'Write a short summary, because RubyGems requires one.'

  s.add_dependency('rspec', '~> 3.0')
  s.add_dependency('zeitwerk', '~> 2.6')
end
