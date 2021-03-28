# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Generators < AddOn
      def apply
        directory('lib/generators/rails/navigation', 'lib/generators/rails/navigation') if uses?(:views)

        template = 'lib/generators/rails/scaffold_controller_generator'
        template(template) if uses?(:scaffold)

        # TODO: Adjust for rspec
        generators = <<-RUBY
    config.generators do |generate|
        #{"require_relative '../lib/generators/rails/scaffold_controller_generator" if uses?(:scaffold)}
        generate.helper false
        generate.javascripts false
        generate.request_specs false
        generate.routing_specs false
        generate.stylesheets false
        generate.test_framework :rspec
        generate.view_specs false
        #{'generate.jb true' if uses?(:jb)}
        #{'generate.factory_bot true' if uses?(:factory_bot)}
    end
        RUBY
        inject_into_file 'config/application.rb', generators, before: /^ {2}end\n/
      end
    end
  end
end
