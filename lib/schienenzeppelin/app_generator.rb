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

    class_option :skip_test,
                 type: :boolean,
                 aliases: '-T', default: true,
                 desc: 'Skip test files'

    class_option :skip_sidekiq,
                 type: :boolean, default: false,
                 desc: 'Skip sidekiq'

    class_option :skip_rspec,
                 type: :boolean,
                 default: false,
                 desc: 'Skip rspec'

    def initialize(*args)
      super

      return unless options[:api]

      self.options = options.merge(
        skip_high_voltage: true,
        skip_tailwind: true,
        skip_stimulus: true,
        skip_views: true,
        skip_errors: true,
        skip_generators: true
      ).freeze
    end

    def create_root_files
      super

      Gemfile.add_anchor
      add(:irbrc)
      add(:foreman)
      add(:dotenv)
      add(:docker)
      # TODO: Make optional
      # Schienenzeppelin::Helpers::Rubocop.apply
    end

    def create_test_files
      super

      add(:rspec)
      add(:factory_bot)
      add(:shoulda)
    end

    def finish_template
      super
      # These require the presence of config/controllers, so they must be done after everything else
      add(:annotate)
      add(:capistrano)
      add(:continuous_integration)
      add(:devise)
      add(:high_voltage)
      add(:inline_svg)
      add(:jb)
      add(:generators)
      add(:lograge)
      add(:oj)
      add(:pundit)
      add(:services)
      add(:sidekiq)
      add(:tailwind, :stimulus, :stimulus_components)
      add(:views, :errors, :scaffold)
    end

    def after_install
      context[:callbacks].each(&:call)
    end

    def self.banner
      "sz new #{arguments.map(&:usage).join(' ')} [options]"
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end

    def context
      @context ||= { callbacks: [] }
    end

    private

    def add(*addons)
      addons.each do |addon|
        addon = addon.to_s.capitalize.camelize
        "Schienenzeppelin::AddOns::#{addon}"
          .constantize
          .apply(context, options)
      end
    end
  end
end
