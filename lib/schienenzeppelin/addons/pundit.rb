# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Pundit < AddOn
      def apply
        directory 'app/policies', 'app/policies'
        template 'app/controllers/authorized_controller.rb.erb', 'app/controllers/authorized_controller.rb'
      end
    end
  end
end
