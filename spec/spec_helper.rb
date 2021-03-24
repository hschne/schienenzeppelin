# frozen_string_literal: true

require 'schienenzeppelin'

Dir['./spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
