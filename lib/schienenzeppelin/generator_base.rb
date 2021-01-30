# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class GeneratorBase < Rails::Generators::Base
      include Rails::Generators::AppName

      def self.default_source_root
        File.expand_path(File.join('..', '..', 'templates'), __dir__)
      end
    end
  end
end
