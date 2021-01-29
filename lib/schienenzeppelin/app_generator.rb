# frozen_string_literal: true

module Schienenzeppelin
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :database,
                 type: :string,
                 aliases: '-d',
                 default: 'postgresql',
                 desc: "Preconfigure for selected database (options: #{DATABASES.join('/')})"

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
      build(:dotenv)
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

    def gemfile_entries # :doc:
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
