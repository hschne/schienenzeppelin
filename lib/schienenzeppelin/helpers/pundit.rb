# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Pundit < HelperBase
      def apply
        directory 'app/policies', 'app/policies'
        template 'app/controllers/authorized_controller.rb.erb', 'app/controllers/authorized_controller.rb'
      end
    end
  end
end
