# frozen_string_literal: true

module Schienenzeppelin
  class AppBuilder < Rails::AppBuilder
    def readme
      template 'README.md.erb', 'README.md'
    end

    def ruby_version
      template '.tool-versions.erb', '.tool-versions'
    end

    def gitignore
      template '.gitignore.erb', '.gitignore'
    end

    def irbrc
      template '.irbrc.erb', '.irbrc'
    end
  end
end
