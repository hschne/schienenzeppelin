
# TODO

## Phase 2
- GH CI - OK
- Schienenzeppelin Repo CI (notify gem releases, tests)
- Loads of testing
- Hide generators and scaffolds in sz gem, don't copy as templates. See JB, use railtie
## Phase 3
- Name update admin doesn't work?
- Fix capistrano error page and error pages in general
- Custom Logo
- Screencast Script
  - Prep 
    - SSH agent eval
    - Empty GH repo
    - Reset local docker
    - Droplet reset database
  - First generate the tweets application
    sz tweeter
    - Break during creation
    cd tweeter
  - Start everything 
    foreman start
  - First time setup 
    rails db:setup
    rails db:migrate
  - Scaffold
    > rails g scaffold tweet
  - Show Pages
    - Homepage
    - Custom scaffold
      - Create tweet, Edit tweet 
  - For deploy replace deploy.rb repo url
    set :repo_url, "git@github.com:hschne/tweeter.git"
  - For deploy replace production.rb server IP
    server "207.154.218.89", user: "deploy", roles: %w{app db web}
  - Update master key env in Ansible using production env
    cat config/credentials/production.key | xclip -sel clipboard
    - Break to allow update on Ansible
  - Set GH remote and push
    ```
    git remote add origin git@github.com:hschne/tweeter.git
    git branch -M main
    git push -u origin main
    ```
  - Cap production deploy
    cap production deploy
    - Break to allow publishing
  - Show Pages
    - Homepage
    - Custom scaffold
    - Error pages

## Phase 4
- Make everything skippable, manage dependencies between items
- Take advantage of saved config (as rails new does)
- Licensing? 
- Homepage & Newsletter
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
