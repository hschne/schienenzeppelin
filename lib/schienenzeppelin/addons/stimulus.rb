# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Stimulus < AddOn
      depends_on :javascript

      def apply
        rails_command('stimulus:install')
      end
    end
  end
end
