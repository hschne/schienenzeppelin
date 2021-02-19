# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Sidekiq < HelperBase
      def apply
        say 'Setting up sidekiq'
        empty_directory('app/workers')
        create_file('app/workers/.keep')
      end
    end
  end
end
