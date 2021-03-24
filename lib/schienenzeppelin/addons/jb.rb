# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Jb < AddOn
      gem 'jb', '~> 0.8', description: 'Jb is a faster alternative to jbuilder'

      def apply
        template 'spec/support/shoulda_matchers.rb'
      end
    end
  end
end
