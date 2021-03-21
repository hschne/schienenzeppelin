# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Rspec < AddOn
      def apply
        return if @options[:skip_rspec]

        create_file('.rspec', '--require spec_helper')
        template('spec/rails_helper.rb')
        template('spec/spec_helper.rb')
      end
    end
  end
end
