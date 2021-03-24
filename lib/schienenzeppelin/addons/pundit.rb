# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Pundit < AddOn
      gem 'pundit', '~> 2.1', description: 'Minimal and simple authorization objects'

      def apply
        directory 'app/policies', 'app/policies'
        template 'app/controllers/authorized_controller.rb.erb', 'app/controllers/authorized_controller.rb'
      end
    end
  end
end
