# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Annotate < HelperBase
      def apply
        template('lib/tasks/auto_annotate_models.rake', force: true)
      end
    end
  end
end
