# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Stimulus < AddOn
      gem 'stimulus-rails', description: 'Add javascript sprinkles to your views'

      def apply
        rails_command('stimulus:install')
      end
    end
  end
end
