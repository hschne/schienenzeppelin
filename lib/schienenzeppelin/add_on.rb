# frozen_string_literal: true

module Schienenzeppelin
  class AddOn < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    def initialize(options, *)
      super
      @options = options
      @config = self.class.config || { dependencies: [], gems: [] }
    end

    def apply
      raise NotImplementedError
    end

    def gems
      @config[:gems]
    end

    def dependencies
      @config[:dependencies]
    end

    def apply_gems
      return if gems.empty?

      gems.each { |args| apply_gem(*args) }
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

    private

    def apply_gem(*args)
      options = args.extract_options!
      name, *versions = args
      parts = [quote(name)]
      description = options.delete(:description)
      versions = versions.any? ? versions : options.delete(:version)
      Array(versions).each_with_object(parts) { |version, object| object << quote(version) }
      parts << quote(options) unless options.empty?

      write_to_gemfile(description, parts)
    end

    def write_to_gemfile(description, parts)
      in_root do
        str = "gem #{parts.join(', ')}"
        after = /^# Schienenzeppelin\n/
        gemfile = 'Gemfile'
        unless IO.read('Gemfile') =~ after
          say 'Adding SZ section to Gemfile', :yellow
          append_file_with_newline(gemfile, '# Schienenzeppelin', verbose: false)
        end
        inject_into_file(gemfile, "#{str}\n", after: after, verbose: false)
        inject_into_file(gemfile, "# #{description}\n", after: after, verbose: false) if description
      end
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

        instance.apply_gems
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
