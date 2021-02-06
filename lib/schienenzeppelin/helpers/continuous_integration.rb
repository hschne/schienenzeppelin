# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class ContinuousIntegration < HelperBase
      def apply
        say 'Setting up GitHub CI'
        template('.github/workflows/build.yml.erb', '.github/workflows/build.yml')
      end
    end
  end
end
