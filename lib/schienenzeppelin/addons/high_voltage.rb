# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class HighVoltage < AddOn
      gem 'high_voltage', '~> 3.1', description: 'A Rails engine for static pages'

      def apply
        template('config/initializers/high_voltage.rb')
      end
    end
  end
end
