# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Dotenv < AddOn
      def apply
        template '.env.development.erb', '.env.development'
      end
    end
  end
end
