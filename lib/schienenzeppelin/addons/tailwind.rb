# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Tailwind < AddOn
      depends_on :javascript

      def apply
        rails_command('tailwindcss:install')
        template('app/javascript/stylesheets/components.scss')
        insert_into_file 'app/javascript/stylesheets/application.scss' do
          <<~CSS

            @import "components";
          CSS
        end
      end
    end
  end
end
