# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Dotenv < GeneratorBase
      def add_gem
        gem "dotenv-rails"
      end

      def add_files
        template '.env.development.erb', '.env.development'
      end
    end
  end
end
