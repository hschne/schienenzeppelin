# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Services < HelperBase
      def apply
        directory 'app/services', 'app/services'
      end
    end
  end
end
