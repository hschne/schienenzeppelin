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
    end

    def database_yml
      if options[:database] == 'postgresql'
        template 'config/postgresql.yml.erb', 'config/database.yml'
      else
        super
      end
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end
  end
end
