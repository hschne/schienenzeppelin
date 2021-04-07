# frozen_string_literal: true

module Schienenzeppelin
  module GeneratorUtils
    def self.included(base)
      base.extend(ClassMethods)
    end

    protected

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

    module ClassMethods
      def overwrite_default_options!
        databases = Rails::Generators::Database::DATABASES
        class_option :database,
                     type: :string,
                     aliases: '-d',
                     default: 'postgresql',
                     desc: "Preconfigure for selected database (options: #{databases.join('/')})"

        class_option :skip_active_job,
                     type: :boolean,
                     default: true,
                     desc: 'Skip Active Job'
      end

      def generate_addon_options!
        test_frameworks = %w[minitest rspec]
        class_option :test_framework,
                     type: :string,
                     default: 'rspec',
                     desc: "Select a testing framework (options: #{test_frameworks.join('/')})"

        background_jobs = %w[sidekiq].freeze
        class_option :background_jobs,
                     type: :string,
                     default: 'sidekiq',
                     desc: "Select a background processing (options: #{background_jobs.join('/')})"

        deployments = %w[capistrano].freeze
        class_option :deployment,
                     type: :string,
                     default: 'capistrano',
                     desc: "Select a deployment option (options: #{deployments.join('/')})"

        version_managers = %w[asdf].freeze
        class_option :version_manger,
                     type: :string,
                     default: 'asdf',
                     desc: "Select your Version Manager (options: #{version_managers.join('/')})"
      end

      def generate_addon_skips!
        Context.new.addons.each do |addon|
          class_option "skip_#{addon}".to_sym,
                       type: :boolean,
                       default: false,
                       desc: "Skip #{addon.underscore.titleize}"
        end
      end
    end
  end
end
