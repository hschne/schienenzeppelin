
# Script

## Prep

- SSH agent eval
- Empty GH repo
- Reset local docker
- Droplet reset database (but make sure DB exists!)
- Make sure spring boot is not on

## Steps

When you start a new application with Rails, I usually spend ours adding things to make it production ready. From database configuration, to little 
development tweaks, to thing like authentication and styling. Wouldn't it be nice if generating a new application gave you 
all these things out of the box?

Schienenzeppelin was made to create a production ready app that you can deploy within minutes. And that's exactly what I'll show here.

After you've installed the gem, just run it to create a new application.

```bash
sz tweeter
```

This generates a new application, like rails new, but with some tweaks. The focus here is to get a nice looking, functional 
application to production as quick as possible. 

That includes
- Basic styling - using Tailwind
- Authentication using Devise
- A production ready database and credential setup
- And capistrano deployment out of the box

There are tons of little details and utilities included, I'll leave a link in the description for you to check out.

Now that that's done, let's have a look at what we got.
```bash
cd tweeter
```

Now the first nice thing is that although we depend on things like postgres and redis for example for Sidekiq, there's no need to install
any of that if you have docker and docker compose. Foreman start to start everything
```ruby
foreman start
```
We still have to do the usual first time setup
```
rails db:setup
rails db:migrate
```
Out of the box we get a responsive homepage, and devise integration, with custom views to boot. A seedfile is provided
to generate an admin user
```
rails db:seed
```
So we can login, and edit our profile if we want. 

Let's add a new model and see how that looks.
```bash
rails g scaffold tweet
rails db:migrate
```
We can see that that generates a new link, and the scaffold is styled too.

That's dandy and all, let's deploy that thing. We have to edit some files for that.
```
vim config/deploy.rb
set :repo_url, "git@github.com:hschne/tweeter.git"
```

This assumes you already have set up a server. I'll also leave a link how to set one up.
```
vim config/production.rb
server "207.154.218.89", user: "deploy", roles: %w{app db web}
```

Before we can deploy, let's push our changes:
```
git add . && git commit -m "Initial commit"
git remote add origin git@github.com:hschne/tweeter.git
git branch -M main
git push -f -u origin main 
```

And deploy
```
cap production deploy
```

Get secret key

```
cat config/credentials/production.key | xclip -sel clipboard
```

BREAK

Once that is finished, we can check out the deployed version.

And that is how you deploy a nice looking production ready app using Schienenzeppelin. 

Let me know what you think, and have fun!

