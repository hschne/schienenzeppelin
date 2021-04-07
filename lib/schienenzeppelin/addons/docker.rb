# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Docker < AddOn
      def apply
        template 'Dockerfile.erb', 'Dockerfile'
        template '.dockerignore.erb', '.dockerignore'
      end
    end
  end
end
