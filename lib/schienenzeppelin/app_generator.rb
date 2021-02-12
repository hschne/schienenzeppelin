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
                 desc: 'Skip jbuilder gem'

    class_option :skip_test,
                 type: :boolean,
                 aliases: '-T', default: true,
                 desc: 'Skip test files'

    class_option :skip_sidekiq,
                 type: :boolean, default: false,
                 desc: 'Skip sidekiq'

    class_option :skip_rspec,
                 type: :boolean,
                 aliases: '-T', default: false,
                 desc: 'Skip rspec'

    def create_config_files
      super
      Schienenzeppelin::Helpers::Generators.apply
    end

    def create_root_files
      super

      build(:irbrc)
      build(:foreman)
      build(:dotenv)
      build(:docker)
      build(:docker_compose)
    end

    def create_test_files
      build(:test) unless options[:skip_test]
      build(:rspec) unless options[:skip_rspec]
      build(:factory_bot) unless options[:skip_factory_bot]
      build(:shoulda) unless options[:skip_shoulda]
    end

    def finish_template
      super
      # These require the presence of config/controllers, so they must be done after everything else
      Schienenzeppelin::Helpers::Annotate.apply
      build(:lograge)
      build(:high_voltage)
      build(:pundit)
      Schienenzeppelin::Helpers::Services.apply unless options[:skip_services]
      build(:sidekiq)
    end

    def after_install
      Schienenzeppelin::Helpers::Devise.apply
      Schienenzeppelin::Helpers::Stimulus.apply
      # TODO: Re-enable with Rails 6.2
      # Schienenzeppelin::Helpers::Hotwire.apply
      Schienenzeppelin::Helpers::Tailwind.apply
      Schienenzeppelin::Helpers::StimulusComponents.apply

      Schienenzeppelin::Helpers::Home.apply
      Schienenzeppelin::Helpers::Errors.apply
      Schienenzeppelin::Helpers::Scaffold.apply

      Schienenzeppelin::Helpers::ContinuousIntegration.apply
      Schienenzeppelin::Helpers::Capistrano.apply
    end

    def self.banner
      "sz new #{arguments.map(&:usage).join(' ')} [options]"
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end
  end
end
