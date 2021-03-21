# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Sidekiq < AddOn
      def apply
        say 'Setting up sidekiq'
        empty_directory('app/workers')
        create_file('app/workers/.keep')
      end
    end
  end
end
