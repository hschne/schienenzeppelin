# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Scaffold < AddOn
      depends_on :views

      def apply
        directory 'lib/templates/erb/scaffold', 'lib/templates/erb/scaffold'
      end
    end
  end
end
