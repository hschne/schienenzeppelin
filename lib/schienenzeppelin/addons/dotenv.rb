# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Dotenv < AddOn
      gem 'dotenv-rails', group: %i[development test], description: 'A convenient way to manage environment variables'

      def apply
        template '.env.development.erb', '.env.development'
      end
    end
  end
end
