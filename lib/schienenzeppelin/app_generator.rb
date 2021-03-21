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
      add(:generators)
    end

    def create_root_files
      super

      add(:irbrc)
      add(:foreman)
      add(:dotenv)
      add(:docker)
      # TODO: Make optional
      # Schienenzeppelin::Helpers::Rubocop.apply
    end

    def create_test_files
      return if options[:skip_test]

      add(:rspec)
      add(:factory_bot)
      add(:shoulda)
    end

    def finish_template
      super
      # These require the presence of config/controllers, so they must be done after everything else
      add(:annotate)
      add(:lograge)
      add(:high_voltage)
      add(:pundit)
      add(:services)
      add(:sidekiq)
    end

    def after_install
      # These all require some gem to be installed
      add(:devise)
      add(:tailwind, :stimulus, :stimulus_components)
      add(:home, :errors, :scaffold)
      add(:continuous_integration)
      add(:capistrano)
    end

    def self.banner
      "sz new #{arguments.map(&:usage).join(' ')} [options]"
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end

    private

    def add(*addons)
      addons.each do |addon|
        addon = addon.to_s.capitalize.camelize
        "Schienenzeppelin::AddOns::#{addon}"
          .constantize
          .new(options)
          .apply
      end
    end
  end
end
