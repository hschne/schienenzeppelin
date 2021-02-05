# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Tailwind < HelperBase
      def apply
        rails_command('tailwindcss:install')
        insert_into_file 'app/javascript/stylesheets/application.scss' do
          <<-CSS
            .btn {
              @apply font-bold py-2 px-4 rounded;
            }

            .btn-default {
              @apply bg-blue-500 text-white;
            }

            .btn-blue:hover {
              @apply bg-blue-700;
            }

            .btn-warn {
              @apply bg-red-500 text-white;
            }

            .btn-warn:hover {
              @apply bg-red-700;
            }
          CSS
        end
      end
    end
  end
end
