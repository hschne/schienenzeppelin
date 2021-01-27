# frozen_string_literal: true

require "date"
require_relative "lib/schienenzeppelin/version"

Gem::Specification.new do |spec|
  spec.name = "Schienenzeppelin"
  spec.version = Schienenzeppelin::VERSION
  spec.authors = ["Hans-Jörg Schnedlitz"]
  spec.email = ["hans.schnedlitz@gmail.com"]
  spec.date = Date.today.strftime("%Y-%m-%d")

  spec.summary = "Create flexible and fast aggregation queries with graphql-ruby"
  spec.description = <<~HEREDOC
    GraphQL Groups makes it easy to add aggregation queries to your GraphQL schema. It combines a simple, flexible 
    schema definition with high performance
  HEREDOC
  spec.license = "MIT"
  spec.homepage = "https://github.com/hschne/schienenzeppelin"

  spec.required_ruby_version = Gem::Requirement.new(">= #{Schienenzeppelin::RUBY_VERSION}")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hschne/schienenzeppelin"
  spec.metadata["changelog_uri"] = "https://github.com/hschne/schienenzeppelin/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", Schienenzeppelin::RAILS_VERSION
end
