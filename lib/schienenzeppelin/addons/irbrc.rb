# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Lograge < AddOn
      def apply
        template '.irbrc.erb', '.irbrc'
      end
    end
  end
end
