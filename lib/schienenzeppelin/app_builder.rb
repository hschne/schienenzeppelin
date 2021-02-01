# frozen_string_literal: true

module Schienenzeppelin
  class AppBuilder < Rails::AppBuilder
    def app
      super
      Schienenzeppelin::Helpers::Views.apply
    end

    def bin
      super
      template 'bin/setup.erb', 'bin/setup', force: true
    end

    def credentials
      super
      # This sets up credentials using a custom template for both development and production use
      Schienenzeppelin::Helpers::Credentials.apply
    end

    def readme
      template 'README.md.erb', 'README.md'
    end

    def ruby_version
      template '.tool-versions.erb', '.tool-versions'
    end

    def gemfile
      template 'Gemfile.erb', 'Gemfile'
    end

    def gitignore
      template '.gitignore.erb', '.gitignore'
    end

    def irbrc
      template '.irbrc.erb', '.irbrc'
    end

    def docker
      template 'Dockerfile.erb', 'Dockerfile'
      template '.dockerignore.erb', '.dockerignore'
      template 'docker-compose.yml.erb', 'docker-compose.yml'
    end

    def dotenv
      template '.env.development.erb', '.env.development'
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

    def lograge
      template 'config/initializers/lograge.rb'
    end

    def services
      Schienenzeppelin::Helpers::Services.apply
    end

    def sidekiq
      Schienenzeppelin::Helpers::Sidekiq.apply
    end

    def pundit
      Schienenzeppelin::Helpers::Pundit.apply
    end

    def rspec
      Schienenzeppelin::Helpers::Rspec.apply
    end

    def shoulda
      template 'spec/support/shoulda_matchers.rb'
    end

    def high_voltage
      Schienenzeppelin::Helpers::HighVoltage.apply
    end

    def factory_bot
      Schienenzeppelin::Helpers::FactoryBot.apply
    end
  end
end
