# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Pundit < HelperBase
      def apply
        directory 'app/policies', 'app/policies'
        inject_into_file 'app/controllers/application_controller.rb',
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY
  include pundit
          RUBY
        end
        inject_into_file 'app/controllers/application_controller.rb',
                         before: "end\n" do
          <<-RUBY
  
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
          RUBY
        end
      end

    end
  end
end
