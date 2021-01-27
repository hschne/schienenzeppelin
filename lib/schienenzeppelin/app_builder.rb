# frozen_string_literal: true

require 'rails'
require "rails/generators/app_base"

module Schienenzeppelin
  class AppBuilder < Rails::AppBuilder
    def readme
      template "README.md.erb", "README.md"
    end

    def ruby_version
      template ".tool-versions.erb", ".tool-versions"
    end
  end
end
