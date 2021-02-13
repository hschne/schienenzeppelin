<h1 align="center">Schienenzeppelin</h1>

<p align="center">
<img src="https://github.com/hschne/schienenzeppelin/workflows/Ruby/badge.svg"/>
<img src="https://badge.fury.io/rb/pundit.svg"/>
<img src="https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability"/>
</p>

<p align="center">A <a href="https://rubyonrails.org/">Ruby on Rails</a> app generator with batteries included</p>

![zeppelin](./schienenzeppelin.jpg)

## Getting Started

Install the Schienenzeppelin gem:

```
gem install schienenzeppelin
```

Make sure you have [Ruby](https://www.ruby-lang.org/en/) and [ Yarn ](https://yarnpkg.com/) installed. Then run:

```
sz new <app-name>
```

See [What's in the Box](#whats-in-the-box) for details on what's included in your new app.

## What's in the Box?

Loads of things!

Schienenzeppelin provides you with a ready-to-go Rails app that you can take to production in a matter of minutes. It comes pre-configured with several gems and utilities that - while kind of standard - are not included in the default Rails app generator. Some highlights include:

- Fully responsive pages using [TailwindCSS](https://tailwindcss.com/) and [High Voltage](https://github.com/thoughtbot/high_voltage) out of the box. And custom scaffolds to boot! :sparkles:
- Authentication comes standard. Starting your app with Schienenzeppelin means [Devise](https://github.com/heartcombo/devise) is already set up :police:
- Dockerized everything. That includes a Dockerfile to get you started with containerizing your app, and a [docker-compose](https://docs.docker.com/compose/)-powered development environment :whale:
- Deploying your app is easy as pie. All the basic [Capistrano](https://capistranorb.com/) configuration is done already, just put in your server location and you are off to the races :rocket:

### Frontend

The nice thing about Schienenzeppelin is that it sets you up with basic pages that don't look like garbage - allowing you to focus on other things than design.

Curious what that looks like? Check out the [[Gallery]]!

#### Tailwind CSS

Schienenzeppelin comes pre-configured with [tailwindcss-rails](https://github.com/rails/tailwindcss-rails). We provide several UI components as a starting point in `app/javascript/stylesheets/components.scss` - easy to adapt, and easy to add your own.

#### Custom Views

[High Voltage](https://github.com/thoughtbot/high_voltage) offers an easy way to add static pages - no controllers needed. Out of the box, Schienenzeppelin provides a mobile-friendly home page and an improved application layout.

#### Custom Scaffold

Schienenzeppelin adds a bunch of scaffolds that you adapt to suit your own needs in `lib/scaffolds`. These scaffolds take advantage of Tailwind to match the look of the rest of your application.

#### Turbo

[Hotwire](https://hotwire.dev/) is the new hotness. Starting with Schienenzeppelin means that Hotwire and its components such as [Stimulus](https://github.com/hotwired/stimulus) are already added to your application.

Schienenzeppelin also takes advantage of [Tailwind-Stimulus-Components](https://github.com/excid3/tailwindcss-stimulus-components) to provide interactive componenets (Dropdowns, Alerts...) out of the box.

### Backend

Modern web apps need tons of functionality out of the box. Authentication, Authorization, APIs and much more. Schienenzeppelin comes with some basics to get you started quickly.

#### Authentication

Devise is already configured if you start your application with Schienenzeppelin. For a smooth first start, `db/seeds.rb` create an admin user, and your navigation bar already contains links where users can sign in or sign up.

#### Authorization

[Pundit](https://github.com/varvet/pundit) provides a simple way to encapsulate authorization logic in your application. You can add new policies to the `app/policies` folder. To generate a new policy run `rails generate pundit:policy`.

#### Background Jobs

Schienenzeppelin per default foregoes ActiveJob in favor of [Sidekiq](https://github.com/mperham/sidekiq).

#### OJ

To serialize and deserialize to and from Json [OJ](https://github.com/ohler55/oj) is pretty much standard. Schienenzeppelin already comes pre-configured with it.

#### JB

For rendering JSON views we use [JB](https://github.com/amatsuda/jb) instead of [JBuilder](https://github.com/rails/jbuilder), as it is both faster and simpler to use.

#### Service Objects

[Service Objects](https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial) are a simple, straight-forward way to encapsulate your business logic and keep your controllers and models nice and slim.

Schienenzeppelin provides a basic service object base class you can inherit from to add your own service objects in `app/services`.

### Development

#### Setup Script

A setup script that allows for easy setup of the application on a new machine is provided. It is automatically tailored to your specific
app configuration.

#### Start Script

Once you have set up everything your application can be started with a single command-line call - using Foreman. All necessary procfiles are generated.

#### Better Rails Console

Schienenzeppelin comes with a custom `.irbrc` that adds history and syntax completion. [Factory Bot](#factory_bot) methods will also be available in the console.

#### Annotate

[Annotate](https://github.com/ctran/annotate_models) adds comments to your models to show the current table schema. Automatically run during each migration.

#### Database

PostgreSQL is already configured if you start your app - in such a way that it plays nicely with other utilities such as `dotenv` and `docker-compose` too!

#### Dotenv

[Dotenv](https://github.com/bkeepers/dotenv) is a nifty gem that makes environment variables easier to manage.

#### Docker

Docker is incredibly helpful when developing and deploying your application. Schienenzeppelin provides a `docker-compose` file
as well as an optimized `Dockerfile` (with complementary `.dockerignore`) to get you started.

#### Version Manager Support

We added support for the [asdf version manager](https://asdf-vm.com/#/). A `.tool-versions` file is automatically included in your app.

#### Improved Gitignore

Schienenzeppelin provides a custom `.gitignore` that is tailored to your app.

#### Rubocop

Creating your app with Schienenzeppelin will automatically add Rubocop and a minimal set of Rubocop rules for both your production and test code.

#### Improved Credentials

While Rails secrets are usually prepared for development, Schienezeppelin sets up everything for production as well.

#### Rspec

[Rspec](https://github.com/rspec/rspec) and its helpers [rspec-mocks](https://github.com/rspec/rspec-mocks) and [shoulda](https://github.com/thoughtbot/shoulda) come standard.

#### Factorybot

[Factorybot](https://github.com/thoughtbot/factory_bot) provides an easy way to create test data.

### Deployment & CI

#### Github Actions

Schienenzeppelin already comes with a workflow file that should cover your basic need. A good starting point for further customization.

#### Capistrano

Capistrano is already set up. Deploy to a server of your choice with minimal effort.

## FAQ

#### Why another template generator?

I wanted something that fits the way I like to write my Rails app. There are many application templates, but this one is mine.

#### What's with the German gibberish name?

I'm so glad you asked. The [Schienenzeppelin](https://en.wikipedia.org/wiki/Schienenzeppelin) was an experimental railcar that was briefly in operation during the 1930s. It was pretty fast, and it ran on Rails. Get it? :zany_face:

#### Credits

This idea is nothing new, and there are tons of other projects I took inspiration from.

Special shout out to Chris Oliver, whose [Jumpstart Pro](https://jumpstartrails.com/) is crazy good. You should get it.

[Suspenders](https://github.com/thoughtbot/suspenders) was where I first came across the idea to try my hand at custom template generators.
