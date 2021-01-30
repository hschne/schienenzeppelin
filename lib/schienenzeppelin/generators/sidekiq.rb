# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Sidekiq < GeneratorBase
      def add_gem
        gem 'sidekiq'
        directory 'app/jobs', 'app/jobs'
        template 'config/initializers/sidekiq.rb'
      end
    end
  end
end
