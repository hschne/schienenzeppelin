# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Lograge < AddOn
      gem 'lograge', description: 'An attempt to tame noisy Rails logs'

      def apply
        template 'config/initializers/lograge.rb'
      end
    end
  end
end
