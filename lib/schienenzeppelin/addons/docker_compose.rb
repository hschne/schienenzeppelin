# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class DockerCompose < AddOn
      def apply
        template 'docker-compose.yml.erb', 'docker-compose.yml'
      end
    end
  end
end
