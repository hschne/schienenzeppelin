# frozen_string_literal: true

module Schienenzeppelin
  class AddOn < Rails::Generators::Base
    include Thor::Actions
    include Rails::Generators::Actions
    include Rails::Generators::AppName

    def initialize(options, *)
      super
      @options = options
    end

    def apply
      raise NotImplementedError
    end

    class << self
      def default_source_root
        File.expand_path(File.join('..', '..', 'templates'), __dir__)
      end

      def apply(options = {})
        new(options).apply
      end
    end
  end
end
