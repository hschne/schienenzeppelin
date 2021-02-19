# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Generators < HelperBase
      def apply
        directory('lib/generators', 'lib/generators')
        generators = <<-RUBY
    config.generators do |generate|
        require_relative '../lib/generators/rails/scaffold_controller_generator'
        generate.helper false
        generate.javascripts false
        generate.request_specs false
        generate.routing_specs false
        generate.stylesheets false
        generate.test_framework :rspec
        generate.view_specs false
        generate.jb true
        generate.factory_bot true
    end
        RUBY
        inject_into_file 'config/application.rb', generators, before: /^ {2}end\n/
      end
    end
  end
end
