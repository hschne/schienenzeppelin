# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Views < HelperBase
      def apply
        directory 'app/views', 'app/views', force: true
        copy_file 'app/assets/images/logo.svg'
      end
    end
  end
end
