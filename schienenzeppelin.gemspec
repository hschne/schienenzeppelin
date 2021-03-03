# frozen_string_literal: true

require 'date'
require_relative 'lib/schienenzeppelin/version'

Gem::Specification.new do |spec|
  spec.name = 'schienenzeppelin'
  spec.version = Schienenzeppelin::VERSION
  spec.authors = ['Hans-Jörg Schnedlitz']
  spec.email = ['hans.schnedlitz@gmail.com']

  spec.summary = 'The Rails app generator that gets you started quickly'
  spec.description = <<~HEREDOC
    Schienenzeppelin is the Ruby on Rails app generator to get you started quickly. Includes TailwindCSS,
    Devise, Capistrano and much more.
  HEREDOC
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/hschne/schienenzeppelin'

  spec.required_ruby_version = Gem::Requirement.new(">= #{Schienenzeppelin::RUBY_VERSION}")

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hschne/schienenzeppelin'
  spec.metadata['changelog_uri'] = 'https://github.com/hschne/schienenzeppelin/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', Schienenzeppelin::RAILS_VERSION
end
