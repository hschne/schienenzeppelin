# frozen_string_literal: true

namespace :sidekiq do
  desc 'Quiet sidekiq (stop fetching new tasks from Redis)'
  task :quiet do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl, '--user', 'kill', '-s', 'SIGTSTP', 'sidekiq.service',
              raise_on_non_zero_exit: false
    end
  end

  desc 'Stop sidekiq (graceful shutdown within timeout, put unfinished tasks back to Redis)'
  task :stop do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl, '--user', 'kill', '-s', 'SIGTERM', 'sidekiq.service',
              raise_on_non_zero_exit: false
    end
  end

  desc 'Start sidekiq'
  task :start do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl, '--user', 'enable', 'sidekiq.service'
      execute :systemctl, '--user', 'start', 'sidekiq.service'
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl, '--user', 'restart', 'sidekiq.service'
    end
  end
end
