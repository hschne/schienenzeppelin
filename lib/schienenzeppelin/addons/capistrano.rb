# frozen_string_literal: true

module Schienenzeppelin
  module AddOns
    class Capistrano < AddOn
      gem 'capistrano-rbenv', '~> 2.2', '>= 2.1.4', require: false, group: :development
      gem 'capistrano-passenger', '~> 0.2.0', require: false, group: :development
      gem 'capistrano', '~> 3.15', require: false, group: :development
      gem 'capistrano-rails', '~> 1.6', require: false, group: :development, description: 'Deploy your application'

      def apply
        @context[:callbacks] << proc do
          say 'Installing and configuring Capistrano'
          run('bundle exec cap install', capture: true)
          directory('lib/capistrano', 'lib/capistrano')

          configure_deploy

          template('Capfile.erb', 'Capfile', force: true)
        end
      end

      private

      def configure_deploy
        gsub_file('config/deploy.rb', /set :application, .+/, "set :application, '#{app_name}'")
        uncomment_lines('config/deploy.rb', /set :deploy_to/)
        gsub_file('config/deploy.rb', /set :deploy_to, .+"/, 'set :deploy_to, "/home/deploy/#{fetch :application}"') # rubocop:disable Lint/InterpolationCheck

        uncomment_lines('config/deploy.rb', /set :keep_releases/)
        uncomment_lines('config/deploy.rb', /append :linked_dirs/)
        uncomment_lines('config/deploy.rb', /ask :branch/)
        gsub_file('config/deploy.rb', /ask :branch/, 'set :branch')
        append_to_file('config/deploy.rb') do
          <<~RUBY
            set :passenger_restart_with_sudo, true
          RUBY
        end
      end
    end
  end
end
