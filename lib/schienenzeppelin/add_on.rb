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

    def uses?(identifier = nil)
      identifier ||= self.class.identifier
      options = @context.options
      return false if options["skip_#{identifier}".to_sym]

      clazz = identifier.nil? ? self.class : self.class.get(identifier)
      Dependencies.new(clazz, @context).satisfied?
    end

    class << self
      def default_source_root
        File.expand_path(File.join('..', '..', 'templates'), __dir__)
      end

      def apply(context = Context.new({}))
        instance = new(context)
        return unless instance.uses?

        instance.apply
      end

      def get(addon)
        addon = addon.to_s.capitalize.camelize
        "Schienenzeppelin::AddOns::#{addon}".constantize
      end

      def identifier
        name.demodulize.underscore.to_sym
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
