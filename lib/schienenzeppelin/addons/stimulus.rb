# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Stimulus < AddOn
      def apply
        rails_command('stimulus:install')
      end
    end
  end
end
