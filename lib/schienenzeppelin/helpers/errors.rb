# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Errors < HelperBase
      def apply
        say 'Setting up custom error pages'
        directory('app/views/errors', 'app/views/errors')
        template('app/controllers/errors_controller.rb.erb', 'app/controllers/errors_controller.rb')
        inject_into_file 'config/application.rb', routes, before: "end\n" do
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
