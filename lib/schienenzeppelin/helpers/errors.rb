# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Errors < HelperBase
      def apply
        say 'Setting up custom error pages'
        directory('app/views/errors', 'app/views/errors')
        template('app/controllers/errors_controller.rb.erb', 'app/controllers/errors_controller.rb')
        remove_file('public/500.html')
        remove_file('public/404.html')
        remove_file('public/422.html')
        # TODO: With deployment make sure to add copy capistrano task
        # https://www.marcelofossrj.com/recipe/2019/04/14/custom-errors.html
        inject_into_file 'config/application.rb', before: "  end\n" do
          <<-RUBY
    # Enable custom error messages
    config.exceptions_app = routes
          RUBY
        end
        inject_into_file 'config/routes.rb', before: "end\n" do
          <<-RUBY
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
          RUBY
        end
      end
    end
  end
end
