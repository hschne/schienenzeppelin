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

    def dependencies_satisfied?(addon, visited = [])
      return false if @options["skip_#{addon}".to_sym]

      return true if @context.default_addons.include?(addon)

      visited << addon
      dependencies = AddOn.get(addon).dependencies - visited
      dependencies.each do |dependency|
        return false unless dependencies_satisfied?(dependency, visited)
      end
    end
  end
end
