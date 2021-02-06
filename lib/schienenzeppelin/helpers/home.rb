# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Home < HelperBase
      def apply
        say 'Setting up custom landing page'
        directory 'app/views/layouts', 'app/views/layouts', force: true
        directory 'app/views/pages', 'app/views/pages'
        directory 'app/views/shared', 'app/views/shared'
        # Make sure we can access any images put into the images folder
        inject_into_file('app/javascript/application.js',
                         "require.context('../images', true)",
                         before: 'require("stylesheets/application.scss")')
        directory 'app/javascript/images', 'app/javascript/images'
      end
    end
  end
end
