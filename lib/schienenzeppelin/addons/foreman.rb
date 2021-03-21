# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Home < AddOn
      def apply
        template '.foreman.erb', '.foreman'
        template 'Procfile.erb', 'Procfile'
        template 'Procfile.dev.erb', 'Procfile.dev'
      end
    end
  end
end
