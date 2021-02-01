# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Scaffold < HelperBase
      def apply
        directory 'lib/templates', 'lib/templates'
      end
    end
  end
end
