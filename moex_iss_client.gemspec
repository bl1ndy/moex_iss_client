# frozen_string_literal: true

require File.expand_path('lib/moex_iss_client/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'moex_iss_client'
  spec.version               = MoexIssClient::VERSION
  spec.authors               = ['bl1ndy']
  spec.email                 = ['ayoblindstone@gmail.com']

  spec.summary               = 'Ruby client for Moscow Exchange ISS API'
  spec.description           = 'This gem allows to interact with Moscow Exchange ISS API'
  spec.homepage              = 'https://github.com/bl1ndy/moex_iss_client'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.0'

  spec.files = Dir[
    'lib/**/*.rb',
    'moex_iss_client.gemspec',
    'LICENSE',
    'CHANGELOG.md',
    'README.md',
    'Gemfile'
  ]
  spec.extra_rdoc_files = ['README.md']

  spec.add_dependency 'faraday', '~> 2.7', '>= 2.7.4'
  spec.add_dependency 'rexml', '~> 3.2', '>= 3.2.5'

  spec.metadata['rubygems_mfa_required'] = 'false'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/bl1ndy/moex_iss_client/blob/main/CHANGELOG.md'
end
