# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Rspec < AddOn
      gem "rspec-rails"

      def apply
        create_file('.rspec', '--require spec_helper')
        template('spec/rails_helper.rb')
        template('spec/spec_helper.rb')
      end
    end
  end
end
