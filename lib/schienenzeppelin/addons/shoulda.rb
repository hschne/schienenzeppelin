# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Schoulda < AddOn
      def apply
        template 'spec/support/shoulda_matchers.rb'
      end
    end
  end
end
