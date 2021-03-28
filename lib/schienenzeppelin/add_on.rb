# frozen_string_literal: true

module Schienenzeppelin
  class AddOn < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    attr_reader :dependencies

    def initialize(context)
      super
      @context = context
      @dependencies = self.class.dependencies || []
    end

    def apply; end

    class << self
      def default_source_root
        File.expand_path(File.join('..', '..', 'templates'), __dir__)
      end

      def apply(context = Context.new({}))
        options = context.options

        return if options["skip_#{identifier}".to_sym]

        return unless Dependencies.new(self, context).satisfied?

        new(context).apply
      end

      def from_sym(addon)
        addon = addon.to_s.capitalize.camelize
        "Schienenzeppelin::AddOns::#{addon}".constantize
      end

      def identifier
        self.class.name.demodulize.underscore
      end

      def dependencies
        @dependencies ||= []
      end

      protected

      def depends_on(*addon)
        @dependencies = addon.map(&:to_sym)
      end
    end
  end
end
