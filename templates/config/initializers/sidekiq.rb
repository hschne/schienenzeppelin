# frozen_string_literal: true

Sidekiq.configure_server do |config|
  # Add additional sidekiq configuration here

  config.logger.level = Logger::INFO
  # This enables you to use Rails.logger inside a Sidekiq worker
  # See: https://github.com/mperham/sidekiq/issues/1682
  Rails.logger = Sidekiq.logger
end
