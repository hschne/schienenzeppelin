# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Stimulus < HelperBase
      def apply
        rails_command('stimulus:install')

        inject_into_file('app/javascript/packs/application.js', "require.context('../images', true)") do
          <<~JS
            // Start StimulusJS
            import { Application } from "stimulus"
            import { definitionsFromContext } from "stimulus/webpack-helpers"

            const application = Application.start();
            const context = require.context("controllers", true, /.js$/);
            application.load(definitionsFromContext(context));

            // Import and register all TailwindCSS Components
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
