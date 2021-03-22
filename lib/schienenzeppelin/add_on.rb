# frozen_string_literal: true

module Schienenzeppelin
  class AddOn < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    def initialize(options, *)
      super
      @options = options
      @config = self.class.config || { dependencies: [] }
    end

    def apply
      raise NotImplementedError
    end

    def dependencies_satisfied?
      dependencies = @config[:dependencies]
      skipped_dependencies = dependencies.select { |dependency| options["skip_#{dependency}".to_sym] }

      if skipped_dependencies.present?
        skipped_string = skipped_dependencies.join(',')
        say "Skipped #{self.class.to_s.demodulize} because it depends on #{skipped_string}", :yellow
        return false
      end

      true
    end


    class << self
      def default_source_root
        File.expand_path(File.join('..', '..', 'templates'), __dir__)
      end

      def apply(options = {})
        addon = self.class.name.to_s.underscore
        return if options["skip_#{addon}".to_sym]

        instance = new(options)
        return unless instance.dependencies_satisfied?

        instance.apply
      end

      attr_reader :config

      protected

      def gem(*gems)

      end

      def depends_on(*addon)
        addons = addon.map(&:to_sym)

        @config ||= {}
        @config[:dependencies] = addons
      end
    end
  end
end
