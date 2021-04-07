# frozen_string_literal: true

module Schienenzeppelin
  class Dependencies
    def initialize(addon, context)
      @addon = addon
      @context = context
      @options = context.options
    end

    def satisfied?
      @addon.dependencies.each do |dependency|
        return false unless dependencies_satisfied?(dependency)
      end

      true
    end

    private

    def dependencies_satisfied?(addon)
      return false if @options["skip_#{addon}".to_sym]

      return true if @context.default_addons.include?(addon)

      dependencies = AddOn.get(addon).dependencies
      dependencies.each do |dependency|
        return false unless dependencies_satisfied?(dependency)
      end
    end
  end
end
