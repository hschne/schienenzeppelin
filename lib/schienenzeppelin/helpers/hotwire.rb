# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Hotwire < HelperBase
      def apply
        rails_command('hotwire:install')
      end
    end
  end
end
