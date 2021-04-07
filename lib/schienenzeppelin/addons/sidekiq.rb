# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Sidekiq < AddOn
      def apply
        say 'Setting up sidekiq'
        directory('app/workers', 'app/workers')
      end
    end
  end
end
