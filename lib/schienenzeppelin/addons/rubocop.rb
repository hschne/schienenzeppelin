# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Rubocop < AddOn
      gem 'rubocop', '~> 1.10', require: false, group: %i[development test]

      def apply
        template '.rubocop.yml.erb', '.rubocop.yml'
      end
    end
  end
end
