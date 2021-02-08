<h1 align="center">Schienenzeppelin</h1>

<p align="center">
<img src="https://github.com/hschne/schienenzeppelin/workflows/Ruby/badge.svg"></>
<img src="https://badge.fury.io/rb/pundit.svg"></>
<img src="https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability"></>
</p>

<p align="center">From zero to SaaS in minutes using <a href="https://rubyonrails.org/">Ruby on Rails</a></p>

![zeppelin](./schienenzeppelin.jpg)

## Getting Started

Install the schienenzeppelin gem:

```
gem install schienenzeppelin
```

Make sure you have [Ruby](https://www.ruby-lang.org/en/) and [ Yarn ](https://yarnpkg.com/) installed. Then run:

```
sz new <project-name>
```

See [Usage](#usage) for more details.

## What's in the Box?

Loads of things!

Schienenzeppelin provides you with a ready-to-go Rails app that you can take to production in a matter of minutes. It comes pre-configured with a number of gems and utilities that - while kind of the standard - are not included in the default Rails app generator. Some highlights include:

- A mobile-friendly homepage using [TailwindCSS](https://tailwindcss.com/) and [High Voltage](https://github.com/thoughtbot/high_voltage).
- Authentication comes standard. Starting your app with Schienenzeppelin means [Devise](https://github.com/heartcombo/devise) is already set up.
- Deploying your app is easy as pie. All the necessary [Capistrano](https://capistranorb.com/) configuration we did for you.

### Frontend

#### Tailwind CSS

Schienenzeppelinn comes pre-configured with [tailwindcss-rails](https://github.com/rails/tailwindcss-rails). We provide several UI components as a starting point in `app/javascript/stylesheets/components.scss` - easy to adapt, and easy to add your own.

You can skip tailwind-css run Schienenzeppelin with the `skip-tailwind` flag.

```
sz --skip-tailwind=true myapp
```

**Warning**: Several other UI improvements take advantage of Tailwind's utility classes. Skipping tailwind means those won't look as nice as they usually do.

#### Custom Views

[High Voltage](https://github.com/thoughtbot/high_voltage) offers an easy way to add static pages - no controllers needed. Out of the box schienezeppelin provides a mobile friendly home page and an improved application layout.

If you'd rather start from scratch you can use the `skip-views` flag:

```
sz --skip-views myapp
```

#### Custom Scaffold

Schienenzeppelin adds a bunch of scaffolds that you adapt to suit your own needs in `lib/scaffolds`. These scaffolds take advantage of Tailwind to match the rest of your application.

#### Turbo

[Hotwire](https://hotwire.dev/) is the new hotness. Starting with Schienenzeppelin means that Hotwire and its components such as [Stimulus](https://github.com/hotwired/stimulus) are already added to your application.

### Backend

### Authentication

Devise is already configured if you start your application with Schienenzeppelin. For a smooth first start, `db/seeds.rb` create an admin user, and your navigiation bar already contains links where users can sign in or sign up.

<details><summary>Details</summary>
<p>

##### Changes

- `app/controllers/authorized_controller.rb`
- `app/views/pages/home.html.erb`
- `config/initializers/devise.rb`

#### Configuration

To skip Devise use:

```
sz --skip-devise myapp
```

</p>
</details>

### Authorization

[Pundit](https://github.com/varvet/pundit) provides a simple way to encapsulate authorization logic in your application. You can add new policies to the `app/policies` folder. To generate a new policy run `rails generate pundit:policy`.

To skip Pundit use:

```
sz --skip-pundit myapp
```

### Background Jobs

Schienenzeppelin per default foregoes ActiveJob in favor of [Sidekiq](https://github.com/mperham/sidekiq).

<details><summary>Details</summary>
<p>

##### Changes

- `app/controllers/authorized_controller.rb`
- `app/views/pages/home.html.erb`
- `config/initializers/devise.rb`

##### Configuration

To re-enable ActiveJob use

```
sz --skip-active-job=false  myapp
```

To skip Sidekiq use

```
sz --skip-sidekiq=true  myapp
```

</p>
</details>

#### OJ

To serialize and deserialize to and from Json [OJ](https://github.com/ohler55/oj) is pretty much standard. Schienenzeppelin already comes pre configured with it.

#### JB

For rendering JSON views we use [JB](https://github.com/amatsuda/jb) instead of [JBuilder](https://github.com/rails/jbuilder), as it is both faster and simpler to use.

<details><summary>Details</summary>
<p>

##### Configuration

To use Jbuilder instead use:

```
sz --skip-jb=true --skip-jbuilder=false  myapp
```

</p>
</details>

### Development

#### Setup Script

A setup script that allows for easy setup of the application on a new machine is provided. It is automatically tailored to your specific
app configuration.

#### Start Script

Once you have set up everything your application can be started with a single command line call - using Foreman. All necessary procfiles are generated.

#### Better Rails Console

Schienenzeppelin comes with a custom `.irbrc` that adds history and syntax completion. If [Factory Bot](#factory_bot) is enabled support
for Factory methods is also added.

#### Database

PostgreSQL is already configured if you start your app - in such a way that it plays nicely with other utlities such as `dotenv` and `docker-compose` too!

#### Dotenv

[Dotenv](https://github.com/bkeepers/dotenv) is a nifty gem that makes environment variables easier to manage.

#### Docker

Docker is incredibly helpful when developing and deploying of your application. Schienenzeppelin provides a `docker-compose` file
as well as an optimized `Dockerfile` (with complementary `.dockerignore`) to get you started.

#### Version Manager Support

Schienenzeppelin comes with support for the [asdf version manager](https://asdf-vm.com/#/).

#### Improved Gitignore

Schienenzeppelin provides a custom `.gitignore` that specifically tailored to your app.

#### Rubocop

Creating your app with Schienenzeppelin will automatically add Rubocop and a minimal set of Rubocop rules for both your production and test code.

#### Webpacker

Webpacker is enabled per default.

#### Credentials

While Rails secrets are usually prepared for development, Schienezeppelin sets up everything for production as well.

#### Rspec

[Rspec](https://github.com/rspec/rspec) and its helpers [rspec-mocks](https://github.com/rspec/rspec-mocks) and [shoulda](https://github.com/thoughtbot/shoulda) come standard.

#### Factorybot

[Factorybot](https://github.com/thoughtbot/factory_bot) provides an easy way to create test data.

### Deployment & CI

#### Github Actions

#### Capistrano

- `./bin/deploy` script
- Github Action workflow for CI
- Dockerfile - OK
- Docker compose file - OK

## Usage

TODO

## FAQ

#### Why not Suspenders/Jumpstart etc?

I wanted something that fits the way I like to write my Rails app. There are many application templates, but this one is mine.

#### What's with the German gibberish name?

I'm so glad you asked. The [Schienenzeppelin](https://en.wikipedia.org/wiki/Schienenzeppelin) was an experimental railcar which was briefly in operation during the 1930s. It was pretty fast, and it ran on Rails. Get it? :zany_face:
