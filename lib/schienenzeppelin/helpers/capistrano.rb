# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Capistrano < HelperBase
      def apply
        say 'Installing and configuring Capistrano'
        run('bundle exec cap install')
        directory('lib/capistrano', 'lib/capistrano')

        uncomment_lines('Capfile', /capistrano\/rbenv/)
        uncomment_lines('Capfile', /capistrano\/passenger/)

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
