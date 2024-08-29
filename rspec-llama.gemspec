# frozen_string_literal: true

# stub: rspec-llama 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = 'rspec-llama'
  s.version = '0.1.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  if s.respond_to? :metadata=
    s.metadata = { 'allowed_push_host' => "TODO: Set to 'http://mygemserver.com'",
                   'changelog_uri' => 'https://example.com', 'homepage_uri' => 'https://example.com', 'source_code_uri' => 'https://example.com',
                   'rubygems_mfa_required' => 'true' }
  end
  s.require_paths = ['lib']
  s.authors = ['Vadser']
  s.bindir = 'exe'
  s.description = 'Write a longer description or delete this line.'
  s.email = ['vadser1999@gmail.com']
  s.files = Dir['CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*.rb']
  s.homepage = 'https://example.com'
  s.licenses = ['MIT']
  s.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  s.summary = 'Write a short summary, because RubyGems requires one.'

  s.installed_by_version = '3.5.3' if s.respond_to? :installed_by_version

  s.add_dependency('rspec')
  s.add_dependency('zeitwerk', '~> 2.6')
end
