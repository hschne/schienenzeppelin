# frozen_string_literal: true

require 'rails'
require_relative "schienenzeppelin/version"
require "rails/generators/app_base"
require "rails/generators/rails/app/app_generator"
require_relative "schienenzeppelin/app_builder"

module Schienenzeppelin
  class Error < StandardError; end

end
