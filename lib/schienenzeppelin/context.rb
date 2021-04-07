# frozen_string_literal: true

module Schienenzeppelin
  class Context
    attr_reader :options, :callbacks

    def initialize(options = {})
      @options = options
      @callbacks = []
    end

    def addons
      AddOns.constants
        .select { |clazz| AddOns.const_get(clazz).is_a?(Class) }
        .map(&:name)
        .map(&:underscore)
    end

    # Skippable parts of the default Rails generator, e.g. active_record, active_job...
    def default_addons
      addon_options = addons.map { |option| "skip_#{option}".to_sym }
      skip_options = Schienenzeppelin::AppGenerator.class_options.keys.select { |key| key =~ /skip_/ }
      (skip_options - addon_options).map { |option| option.to_s.delete_prefix('skip_').to_sym }
    end
  end
end
