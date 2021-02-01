# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class HighVoltage < HelperBase
      def apply
        template('config/initializers/high_voltage.rb')
      end
    end
  end
end
