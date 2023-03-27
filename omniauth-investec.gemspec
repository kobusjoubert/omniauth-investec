# frozen_string_literal: true

require_relative 'lib/omniauth/investec/version'

Gem::Specification.new do |spec|
  spec.name = 'omniauth-investec'
  spec.version = OmniAuth::Investec::VERSION
  spec.authors = ['Kobus Joubert']
  spec.email = ['kobus@translate3d.com']

  spec.summary = 'OmniAuth strategy for Investec Programmable Banking'
  spec.description = 'OmniAuth strategy for Investec Programmable Banking'
  spec.homepage = 'https://github.com/platform45/omniauth-investec'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/platform45/omniauth-investec'
  spec.metadata['changelog_uri'] = 'https://github.com/platform45/omniauth-investec/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth',        '~> 2.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.7'

  spec.add_development_dependency 'debug',   '~> 1.0'
  spec.add_development_dependency 'rake',    '~> 13.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
