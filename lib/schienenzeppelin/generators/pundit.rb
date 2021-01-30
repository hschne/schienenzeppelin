# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Pundit < GeneratorBase
      def add_gem
        gem 'pundit'
        directory 'app/policies', 'app/policies'
        inject_into_file 'app/controllers/application_controller.rb',
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-HEREDOC
  include Pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
          HEREDOC
        end
      end
    end
  end
end
