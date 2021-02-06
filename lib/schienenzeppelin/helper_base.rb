# frozen_string_literal: true

module Schienenzeppelin
  class HelperBase < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    def self.apply(options = {})
      new(options).apply
    end

    def initialize(options, *)
      super
      @options = options
    end

    private_class_method :new

    def apply
      raise NotImplementedError
    end

    def self.default_source_root
      File.expand_path(File.join('..', '..', 'templates'), __dir__)
    end
  end
end
