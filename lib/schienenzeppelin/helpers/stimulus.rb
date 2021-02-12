# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Stimulus < HelperBase
      def apply
        rails_command('stimulus:install')
        run('yarn add stimulus')
      end
    end
  end
end
