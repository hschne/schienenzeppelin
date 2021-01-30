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

    class_option :skip_sidekiq,
                 type: :boolean, default: false,
                 desc: 'Skip Sidekiq'

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

    def credentials
      return if options[:pretend] || options[:dummy_app]

      build(:credentials)
    end

    def finish_template
      gem 'schienenzeppelin', path: '/home/hschne/Source/schienenzeppelin'
      build(:gems)
      super
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
    end
      RUBY

      inject_into_file 'config/application.rb', generators, before: "  end\n"
    end

    def gemfile_entries
      [rails_gemfile_entry,
       database_gemfile_entry,
       web_server_gemfile_entry,
       assets_gemfile_entry,
       webpacker_gemfile_entry,
       javascript_gemfile_entry,
       psych_gemfile_entry,
       cable_gemfile_entry,
       @extra_entries].flatten.find_all(&@gem_filter)
    end
  end
end
