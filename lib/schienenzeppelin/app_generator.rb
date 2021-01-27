# frozen_string_literal: true

module Schienenzeppelin
  class AppGenerator < Rails::Generators::AppGenerator

    def create_root_files
      super

      build(:irbrc)
    end

    protected

    def get_builder_class
      Schienenzeppelin::AppBuilder
    end
  end
end
