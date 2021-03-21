# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Schoulda < AddOn
      def apply
        return if @options[:skip_shoulda]

        template 'spec/support/shoulda_matchers.rb'
      end
    end
  end
end
