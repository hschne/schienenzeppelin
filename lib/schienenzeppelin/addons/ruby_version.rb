# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class RubyVersion < AddOn
      def apply
        template '.tool-versions.erb', '.tool-versions'
      end
    end
  end
end
