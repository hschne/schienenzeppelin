# frozen_string_literal: true

module Schienenzeppelin
  class Context

    attr_reader :options, :callbacks

    def initialize(options)
      @options = options
      @callbacks = []
    end
  end
end
