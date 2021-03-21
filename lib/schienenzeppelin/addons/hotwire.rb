# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Hotwire < AddOn
      def apply
        rails_command('hotwire:install')
      end
    end
  end
end
