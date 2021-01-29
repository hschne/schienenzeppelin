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
      build(:docker)
      build(:docker_compose)
    end

    def finish_template
      invoke(:add_gems)
      super
    end

    def self.banner
      "sz new #{arguments.map(&:usage).join(' ')} [options]"
    end

    def add_gems
      generate("schienenzeppelin:dotenv")
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end

  end
end
