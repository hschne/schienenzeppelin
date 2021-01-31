# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class HighVoltage < HelperBase
      def apply
        template('config/initializers/high_voltage.rb')
        directory('app/views/pages', 'app/views/pages')
      end
    end
  end
end
