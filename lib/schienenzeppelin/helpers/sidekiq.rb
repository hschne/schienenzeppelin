# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Sidekiq < HelperBase
      def apply
        say 'Setting up sidekiq'
        empty_directory('app/workers')
        create_file('app/workers/.keep')
        inject_into_file 'config/environments/development.rb', before: "end\n" do
          <<-RUBY
  if Rails.root.join('tmp', 'sidekiq-dev.txt').exist?
    require 'sidekiq/testing'
    Sidekiq::Testing.inline!
  end
          RUBY
        end
      end
    end
  end
end
