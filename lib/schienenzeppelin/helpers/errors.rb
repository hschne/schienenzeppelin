# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Errors < HelperBase
      def apply
        say 'Setting up custom error pages'
        add_errors
        setup_public
        add_routes
        patch_turbolinks
      end

      private

      def setup_public
        template('public/500.html.erb', 'public/500.html', force: true)
        remove_file('public/404.html')
        remove_file('public/422.html')
      end

      def add_errors
        directory('app/views/errors', 'app/views/errors')
        template('app/controllers/errors_controller.rb.erb', 'app/controllers/errors_controller.rb')
        inject_into_file 'config/application.rb', before: /^ {2}end\n/ do
          <<-RUBY
    # Enable custom error pages
    config.exceptions_app = routes
          RUBY
        end
      end

      def add_routes
        inject_into_file 'config/routes.rb', before: /^end/ do
          <<-RUBY
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
          RUBY
        end
      end

      def patch_turbolinks
        inject_into_file 'app/javascript/packs/application.js' do
          <<~JS
            // Patching turbolinks to allow custom errors
            // See https://github.com/turbolinks/turbolinks/issues/179
            window.Turbolinks.HttpRequest.prototype.requestLoaded = function() {
              return this.endRequest(function() {
                var code = this.xhr.status;
                if (200 <= code && code < 300 ||
                    code === 403 || code === 404 || code === 500) {
                  this.delegate.requestCompletedWithResponse(
                      this.xhr.responseText,
                      this.xhr.getResponseHeader("Turbolinks-Location"));
                } else {
                  this.failed = true;
                  this.delegate.requestFailedWithStatusCode(code, this.xhr.responseText);
                }
              }.bind(this));
            };
          JS
        end
      end
    end
  end
end
