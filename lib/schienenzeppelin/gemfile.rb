# frozen_string_literal: true

module Schienenzeppelin
  class Gemfile < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions

    def add(*args)
      options = args.extract_options!
      name, *versions = args
      parts = [quote(name)]
      versions = versions.any? ? versions : options.delete(:version)

      Array(versions).each_with_object(parts) { |version, object| object << quote(version) }

      description = options.delete(:description)
      group = options.delete(:group)

      parts << quote(options) unless options.empty?

      write_to_gemfile(parts, description, group)
    end

    def add_anchor
      in_root do
        unless IO.read('Gemfile') =~ /^# Schienenzeppelin\n/
          say 'Adding SZ section to Gemfile', :yellow
          append_file_with_newline('Gemfile', '# Schienenzeppelin', verbose: false)
        end
      end
    end

    private

    def write_to_gemfile(parts, description, group)
      in_root do
        @indentation = 1 if group
        group = wrap(group)
        location = group.present? ? /^group #{group.map(&:inspect).join(', ')} do\n/ : /^# Schienenzeppelin\n/

        gemfile = 'Gemfile'
        gem = "#{indentation}gem #{parts.join(', ')}\n"
        inject_into_file(gemfile, gem, after: location, verbose: false)
        if description
          description = "#{indentation}# #{description}\n"
          inject_into_file(gemfile, description, after: location, verbose: false) if description
        end
      end
    end

    def wrap(group)
      if group.nil?
        []
      elsif group.respond_to?(:to_ary)
        group.to_ary || [group]
      else
        [group]
      end
    end

    class << self
      def add(*args)
        new.add(*args)
      end

      def add_anchor
        new.add_anchor
      end
    end
  end
end
