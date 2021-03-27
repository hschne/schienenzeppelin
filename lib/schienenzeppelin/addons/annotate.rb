# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Annotate < AddOn
      gem 'annotate', '~> 3.1',
          group: :development,
          description: 'Add a comment summarizing the current schema to  your code'

      def apply
        template('lib/tasks/auto_annotate_models.rake', force: true)
      end
    end
  end
end
