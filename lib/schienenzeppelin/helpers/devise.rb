# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Devise < HelperBase
      def apply
        generate('devise:install')
        generate(:devise, 'User', 'admin:boolean')
        directory('app/views/devise', 'app/views/devise')

        environment("config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development')

        in_root do
          migration = Dir.glob('db/migrate/*').max_by { |f| File.mtime(f) }
          gsub_file migration, /:admin/, ':admin, default: false'
        end
        insert_into_file 'db/seeds.rb' do
          <<~RUBY
            # Create an initial admin user for development
            User.find_or_create_by(email: "admin@admin.com") do |user|
              user.password = password
              user.admin = true
            end
          RUBY
        end
      end
    end
  end
end
