# frozen_string_literal: true

module Schienenzeppelin
  class Dotenv < Rails::Generators::Base
    def add_gem
      gem "dotenv-rails"
    end

    def add_files
      template '.env.development.erb' '.env.development'
    end
  end
end
