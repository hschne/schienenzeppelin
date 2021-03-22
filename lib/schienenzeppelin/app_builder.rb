# frozen_string_literal: true

module Schienenzeppelin
  class AppBuilder < Rails::AppBuilder
    def bin
      super
      template 'bin/setup.erb', 'bin/setup', force: true
    end

    def credentials
      super
      # This sets up credentials using a custom template for both development and production use
      Schienenzeppelin::AddOns::Credentials.apply
    end

    def readme
      template 'README.md.erb', 'README.md'
    end

    def ruby_version
      Schienenzeppelin::AddOns::RubyVersion.new(options).apply
    end

    def gemfile
      template 'Gemfile.erb', 'Gemfile'
    end

    def gitignore
      template '.gitignore.erb', '.gitignore'
    end

    def database_yml
      if options[:database] == 'postgresql'
        template 'config/postgresql.yml.erb', 'config/database.yml'
      else
        super
      end
    end
  end
end
