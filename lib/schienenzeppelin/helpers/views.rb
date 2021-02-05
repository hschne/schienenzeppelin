# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Views < HelperBase
      def apply
        directory 'app/views/layouts', 'app/views/layouts', force: true
        directory 'app/views/pages', 'app/views/pages'
        directory 'app/views/shared', 'app/views/shared'
        copy_file 'app/assets/images/logo.svg'
      end
    end
  end
end
