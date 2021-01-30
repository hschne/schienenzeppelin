# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Sidekiq < GeneratorBase
      def add_gem
        gem 'sidekiq'
        empty_directory 'app/workers'

        inject_into_file 'config/environments/development.rb', before: "end\n" do
          <<-RUBY
  if Rails.root.join('tmp', 'sidekiq-dev.txt').exist?
    require 'sidekiq/testing'
    Sidekiq::Testing.inline!
  end
          RUBY
        end
      end
    end
  end
end
