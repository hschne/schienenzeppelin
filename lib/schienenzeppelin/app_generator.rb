# frozen_string_literal: true

module Schienenzeppelin
  class AppGenerator < Rails::Generators::AppGenerator
    # Change defaults compared to standard Rails
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

    class_option :skip_sidekiq,
                 type: :boolean, default: false,
                 desc: 'Skip sidekiq'

    class_option :skip_rspec,
                 type: :boolean,
                 default: false,
                 desc: 'Skip rspec'

    class_option :skip_factory_bot,
                 type: :boolean,
                 default: false,
                 desc: 'Skip factory bot'

    class_option :skip_devise,
                 type: :boolean,
                 default: false,
                 desc: 'Skip devise'

    class_option :testing,
                 type: :string,
                 default: 'rspec'

    def initialize(*args)
      super

      puts options
      if options[:api]
        self.options = options.merge(
          skip_errors: true,
          skip_high_voltage: true,
          skip_stimulus: true,
          skip_tailwind: true,
          skip_views: true
        ).freeze
      end

      unless options[:testing] == 'rspec'
        self.options = options.merge(
          skip_rspec: true,
          skip_shoulda: true
        )
      end

      return unless options[:skip_test]

      self.options = options.merge(
        skip_rspec: true,
        skip_shoulda: true,
        skip_factory_bot: true
      )
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

      super if options[:testing] == 'minitest'

      add(:rspec) if options[:testing] == 'rspec'
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

    def context
      @context ||= Context.new(options)
    end

    private

    def add(*addons)
      addons.each do |addon|
        addon = addon.to_s.capitalize.camelize
        "Schienenzeppelin::AddOns::#{addon}"
          .constantize
          .apply(context)
      end
    end
  end
end
