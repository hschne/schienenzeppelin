# frozen_string_literal: true

namespace :deploy do
  desc 'Reload the database with seed data'
  task :seeds do
    on roles(:all) do
      within current_path do
        execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
      end
    end
  end
end
