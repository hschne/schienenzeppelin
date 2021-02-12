# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Stimulus < HelperBase
      def apply
        rails_command('stimulus:install')
      end
    end
  end
end
