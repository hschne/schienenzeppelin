# TODO

## Phase 2

- Proper Icon
- Hide generators and scaffolds in sz gem, don't copy as templates. See JB, use railtie
- More dependency stuff: 
  - Adapt test command in CI
  - Adapt capfile for skips (sidekiq)
  - Adapt docker-compose for skips (database, webpack...)
  - Adapt dockerfile & entrypoint for skips (database, webpack...)
  - Adapt dotenv for skips (database)
  - Adapt setup for skips (database, sidekiq...)
    
- Testplan 
  - Skip ActiveJob
  - Skip Sidekiq
  - Skip Devise
  - Skip Views
  - Skip Tailwind
  - Skip Javascript
  - Skip Webpacker
  - Skip High Voltage
  - Skip Rspec
  - Skip Tests
  
## Phase 3

- Homepage & Newsletter & Docs
- Additional Gems:
  - Pagy
- Take advantage of saved config (as rails new does)
  
## Phase 4

- Licensing?
- Goodies for Business:
  - Admin pages
  - Social Logins
  - Cloud Storage ?
  - Payments
  - Monitoring (Skylight, ...)
  - Email Providers (Mailgun, ...)
  - Reporting (Bugsnag, ...)
  - Dockerfile
  - https://dev.to/citronak/modern-rails-flash-messages-part-1-viewcomponent-stimulus-tailwind-css-3alm
- Configuration wizard via command line
- Alternative configurations:
  - Differernt DB
  - Different BG Jobs
  - Different Deployment
- Ansible repo setup if deploy is Capistrano
