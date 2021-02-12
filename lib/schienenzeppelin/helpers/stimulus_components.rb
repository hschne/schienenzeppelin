# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class StimulusComponents < HelperBase
      def apply
        run('yarn add tailwindcss-stimulus-components')
        inject_into_file('app/javascript/packs/application.js') do
          <<~JS
            import { Application } from "stimulus"
            import { definitionsFromContext } from "stimulus/webpack-helpers"

            const application = Application.start();
            const context = require.context("controllers", true, /.js$/);
            application.load(definitionsFromContext(context));

            import { Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
            application.register('dropdown', Dropdown)
            application.register('modal', Modal)
            application.register('tabs', Tabs)
            application.register('popover', Popover)
            application.register('toggle', Toggle)
            application.register('slideover', Slideover)
          JS
        end
      end
    end
  end
end
