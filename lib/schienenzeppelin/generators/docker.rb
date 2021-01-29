# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Docker < GeneratorBase
      def dockerfile
        template 'Dockerfile.erb', 'Dockerfile'
        template '.dockerignore.erb', '.dockerignore'
      end

      def docker_compose
        template 'docker-compose.yml.erb', 'docker-compose.yml'
      end
    end
  end
end
