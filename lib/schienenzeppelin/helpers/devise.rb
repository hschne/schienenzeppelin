# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Devise < HelperBase
      def apply
        generate('devise:install', capture: true)
        generate(:devise, 'User', 'name', 'admin:boolean', capture: true)
        directory('app/views/devise', 'app/views/devise')

        inject_into_file 'config/environments/development.rb', before: "end\n" do
          "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }"
        end

        db_changes
      end

      private

      def db_changes
        in_root do
          migration = Dir.glob('db/migrate/*').max_by { |f| File.mtime(f) }
          gsub_file migration, /:admin/, ':admin, default: false'
        end
        insert_into_file 'db/seeds.rb' do
          <<~RUBY
            # Create an initial admin user for development
            User.find_or_create_by(email: "admin@admin.com") do |user|
              user.name = 'Admin'
              user.password = 'password'
              user.admin = true
            end
          RUBY
        end
      end
    end
  end
end
