# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Capistrano < HelperBase
      def apply
        say 'Installing and configuring Capistrano'
        run('bundle exec cap install', capture: true)
        directory('lib/capistrano', 'lib/capistrano')

        uncomment_lines('Capfile', /capistrano\/rbenv/)
        uncomment_lines('Capfile', /capistrano\/passenger/)

        gsub_file('config/deploy.rb', /set :application, .+/, "set :application, '#{app_name}'")
        gsub_file('config/deploy.rb', /set :deploy_to, .+"/, "set :deploy_to, home/deploy/\#{fetch :application}")
        uncomment_lines('config/deploy.rb', /set :keep_releases/)

        inject_into_file 'Capfile' do
          <<~RUBY
            Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

            after 'deploy:starting', 'sidekiq:quiet'
            after 'deploy:updated', 'sidekiq:stop'
            after 'deploy:published', 'sidekiq:start'
            after 'deploy:failed', 'sidekiq:restart'
          RUBY
        end
      end
    end
  end
end
