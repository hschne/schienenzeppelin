# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class HighVoltage < AddOn
      def apply
        template('config/initializers/high_voltage.rb')
      end
    end
  end
end
