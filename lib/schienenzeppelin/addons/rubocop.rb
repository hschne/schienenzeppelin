# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Rubocop < AddOn
      def apply
        template '.rubocop.yml.erb', '.rubocop.yml'
      end
    end
  end
end
