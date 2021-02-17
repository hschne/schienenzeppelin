# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Rubocop < HelperBase
      def apply
        template '.rubocop.yml.erb', '.rubocop.yml'
      end
    end
  end
end
