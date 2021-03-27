# frozen_string_literal: true

module Schienenzeppelin
  class AddOn < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    def initialize(context, options, *)
      super
      @context = context
      @options = options
      @config = self.class.config || { dependencies: [], gems: [] }
    end

    def apply; end

    def gems
      @config[:gems]
    end

    def dependencies
      @config[:dependencies]
    end

    def dependencies_satisfied?
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

      def apply(context = {}, options = {})
        addon = self.class.name.to_s.underscore
        return if options["skip_#{addon}".to_sym]

        instance = new(context, options)
        return unless instance.dependencies_satisfied?

        gems = instance.gems
        gems.each { |args| Gemfile.add(*args) }
        instance.apply
      end

      attr_reader :config

      protected

      def gem(*args)
        @config ||= default_options
        @config[:gems] << args
      end

      def depends_on(*addon)
        @config ||= default_options
        addons = addon.map(&:to_sym)
        @config[:dependencies] = addons
      end

      def with_options(options, &block)
        option_merger = ActiveSupport::OptionMerger.new(self, options)
        block.arity.zero? ? option_merger.instance_eval(&block) : block.call(option_merger)
      end

      private

      def default_options
        { dependencies: [], gems: [] }
      end

      def quote(value)
        if value.respond_to? :each_pair

          return value.map do |k, v|
            "#{k}: #{quote(v)}"
          end.join(', ')
        end
        return value.inspect unless value.is_a? String

        if value.include?("'")
          value.inspect
        else
          "'#{value}'"
        end
      end
    end
  end
end
