# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Schoulda < AddOn
      gem 'shoulda-matchers', group: :test

      def apply
        template 'spec/support/shoulda_matchers.rb'
      end
    end
  end
end
