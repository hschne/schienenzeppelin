# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Services < AddOn
      def apply
        directory 'app/services', 'app/services'
      end
    end
  end
end
