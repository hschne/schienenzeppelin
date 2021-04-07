# frozen_string_literal: true

module Schienenzeppelin
  class AppGenerator < Rails::Generators::AppGenerator
    include GeneratorUtils
    overwrite_default_options!

    generate_addon_options!

    generate_addon_skips!

    def initialize(*args)
      super

      if options[:api]
        self.options = options.merge(
          skip_errors: true,
          skip_high_voltage: true,
          skip_stimulus: true,
          skip_tailwind: true,
          skip_views: true
        ).freeze
      end
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

      super if options[:testing_framework] == 'minitest'

      add(:rspec) if options[:testing_framework] == 'rspec'
    end

    def finish_template
      super
      # These require the presence of config/controllers, so they must be done after everything else
      add(:annotate)
      add(:continuous_integration)
      add(:high_voltage)
      add(:generators)
      add(:lograge)
      add(:pundit)
      add(:services)
      add(:sidekiq)
      add(:views, :errors, :scaffold)

      add(:factory_bot)
      add(:shoulda)
    end

    def after_install
      add(:tailwind, :stimulus, :stimulus_components)
      add(:devise)
      add(:capistrano)
    end

    no_tasks do
      def uses?(addon)
        return false if options["skip_#{addon}".to_sym]

        addon = AddOn.get(addon)
        Dependencies.new(addon, context).satisfied?
      end
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
