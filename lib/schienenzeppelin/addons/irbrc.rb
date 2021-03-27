# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Irbrc < AddOn
      def apply
        template '.irbrc.erb', '.irbrc'
      end
    end
  end
end
