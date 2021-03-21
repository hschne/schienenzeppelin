# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Docker < AddOn
      def apply
        template 'Dockerfile.erb', 'Dockerfile'
        template '.dockerignore.erb', '.dockerignore'
        template 'docker-compose.yml.erb', 'docker-compose.yml'
      end
    end
  end
end
