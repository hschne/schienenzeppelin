# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Scaffold < AddOn
      def apply
        directory 'lib', 'lib'
      end
    end
  end
end
