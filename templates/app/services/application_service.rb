# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    instance = new(*args, &block)
    instance.call
  end

  def call
    raise NotImplementedError('Services must implement call')
  end

  private_class_method :new
end
