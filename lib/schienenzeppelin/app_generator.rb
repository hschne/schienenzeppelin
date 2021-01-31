# frozen_string_literal: true

module Schienenzeppelin
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :database,
                 type: :string,
                 aliases: '-d',
                 default: 'postgresql',
                 desc: "Preconfigure for selected database (options: #{DATABASES.join('/')})"

    class_option :skip_active_job,
                 type: :boolean, default: true,
                 desc: 'Skip Active Job'

    class_option :skip_jbuilder,
                 type: :boolean,
                 default: true,
                 desc: "Skip jbuilder gem"

    class_option :skip_test,
                 type: :boolean,
                 aliases: "-T", default: true,
                 desc: "Skip test files"

    class_option :skip_sidekiq,
                 type: :boolean, default: false,
                 desc: 'Skip sidekiq'

    class_option :skip_rspec,
                 type: :boolean,
                 aliases: "-T", default: false,
                 desc: "Skip rspec"

    def initialize(*args)
      super
    end

    def create_config_files
      super
      configure_generators
    end

    def create_root_files
      super

      build(:irbrc)
      build(:foreman)
      build(:docker)
      build(:docker_compose)
    end

    def create_credentials
      super
    end

    def finish_template
      super
      # These require the presence of config/controllers, so they must be done after everything else
      build(:pundit)
      build(:sidekiq)
    end

    def run_installs
      # These steps rely on gems being installed, this is executed at the end of the generator
      generate "rspec:install" unless options[:skip_rspec]
    end

    def self.banner
      "sz new #{arguments.map(&:usage).join(' ')} [options]"
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end

    private

    def configure_generators
      generators = <<-RUBY
    config.generators do |generate|
        generate.helper false
        generate.javascripts false
        generate.request_specs false
        generate.routing_specs false
        generate.stylesheets false
        generate.test_framework :rspec
        generate.view_specs false
        generate.jb true
        generate.factory_bot true
    end
      RUBY

      inject_into_file 'config/application.rb', generators, before: "  end\n"
    end
  end
end
