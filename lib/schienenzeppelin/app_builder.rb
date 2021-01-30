# frozen_string_literal: true

module Schienenzeppelin
  class AppBuilder < Rails::AppBuilder
    def bin
      super
      template 'bin/setup.erb', 'bin/setup', force: true
    end

    def credentials
      Schienenzeppelin::Generators::Credentials.new.invoke_all
    end

    def readme
      template 'README.md.erb', 'README.md'
    end

    def ruby_version
      template '.tool-versions.erb', '.tool-versions'
    end

    def gitignore
      template '.gitignore.erb', '.gitignore'
    end

    def irbrc
      template '.irbrc.erb', '.irbrc'
    end

    def docker
      Schienenzeppelin::Generators::Docker.new.invoke_all
    end

    def foreman
      template '.foreman.erb', '.foreman'
      template 'Procfile.erb', 'Procfile'
      template 'Procfile.dev.erb', 'Procfile.dev'
    end

    def database_yml
      if options[:database] == 'postgresql'
        template 'config/postgresql.yml.erb', 'config/database.yml'
      else
        super
      end
    end

    def gems
      Schienenzeppelin::Generators::Dotenv.new.invoke_all
      Schienenzeppelin::Generators::Pundit.new.invoke_all
      Schienenzeppelin::Generators::Jb.new.invoke_all
      Schienenzeppelin::Generators::Oj.new.invoke_all
      Schienenzeppelin::Generators::Sidekiq.new.invoke_all
    end
  end
end
