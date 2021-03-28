# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Lograge < AddOn
      def apply
        template 'config/initializers/lograge.rb'
      end
    end
  end
end
