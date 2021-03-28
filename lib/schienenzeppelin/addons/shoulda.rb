# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Shoulda < AddOn
      depends_on :rspec

      def apply
        template 'spec/support/shoulda_matchers.rb'
      end
    end
  end
end
