# frozen_string_literal: true

namespace :generate do
  task :error_page do
    on roles(:web) do |host|
      error_page = File.join(release_path, 'public/500.html')
      execute :curl, '-k', "https://#{host.hostname}/500", "> #{error_page}"
    end
  end
end
