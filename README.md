# Schienenzeppelin

Schienenzeppelin is an opinionated, yet configurable, Ruby on Rails app generator. It is  ̶a̶̶̶ ̶̶̶s̶̶̶h̶̶̶a̶̶̶m̶̶̶e̶̶̶l̶̶̶e̶̶̶s̶̶̶s̶̶̶ ̶̶̶r̶̶̶i̶̶̶p̶̶̶-̶̶̶o̶̶̶f̶̶̶f̶̶̶ ̶̶̶o̶̶̶f̶̶̶ inspired by [Suspenders](https://github.com/thoughtbot/suspenders).

![zeppelin](./schienenzeppelin.jpg)

## Getting Started

Install the schienenzeppelin gem: 

```
gem install schienenzeppelin
```

Make sure you have [Ruby](https://www.ruby-lang.org/en/) and [ Yarn ](https://yarnpkg.com/) installed. Then run:

```
schienenzeppelin new <project-name>
```

See [Usage](#usage) for details.

## What's included? 

Schienenzeppelin provides a set of opinionated default configurations for your new Rails app. Additionally, it adds support
for a number of Gems and tweaks to improve both the development and production use of your app.

### Development

Below is a complete list of improvements and tweaks to streamline your development process.

#### Setup Script 

A setup script that allows for easy setup of the application on a new machine is provided. It is automatically tailored to your specific
 app configuration.
 
#### Start Script 

Once you have set up everything your application can be started with a single command line call - using Foreman. All necessary procfiles are generated.
 
#### Better Rails Console

Schienenzeppelin comes with a custom `.irbrc` that adds history and syntax completion. If [Factory Bot](#factory_bot) is enabled support
for Factory methods is also added.

#### Dotenv 

[Dotenv](https://github.com/bkeepers/dotenv) is a nifty gem that makes environment variables easier to manage. 

#### Docker 

Docker is incredibly helpful when developing and deploying of your application. Schienenzeppelin provides a `docker-compose` file
as well as an optimized `Dockerfile` (with complementary `.dockerignore`) to get you started. 

#### Version Manager Support

Schienenzeppelin comes with support for the [asdf version manager](https://asdf-vm.com/#/).

#### Improved Gitignore

Schienenzeppelin provides a custom `.gitignore` that specifically tailored to your app.

#### Opinionated Style 

Creating your app with Schienenzeppelin will automatically create a minimal set of Rubocop rules for both your production and test code.

#### Webpacker

Webpacker is enabled per default.

### Production

- Tailwind CSS
- High Voltage
- Skylight
- Sidekiq
- Oj
- JBuilder
- PostgreSQL: Customized database YML
- Honeybadger
- Hotwire 
- Stimulus 
- Rack Mini Profiler
- Custom Webpacker configuration

### Development
- `.irbrc` configuration
- `bin/setup` script
- Dotenv: Customized settings
- Using .tool_versions for asdf version manager
- Preconfigured vault secret file
- Improved gitignore
- Dotenv: Customized settings
- Bullet
- Byebug
- Opinionated RuboCop setup
- Brakeman & Bundle Audit configurations

### Testing
- Rspec
- Factorybot
- Rspec Mocks
- Rspec Matchers

### Deployment & CI

- `./bin/deploy` script
- Github Action workflow for CI
- Dockerfile
- Docker compose file

## Usage

TODO

## FAQ

#### Why not Suspenders/Jumpstart etc? 

I wanted something that fits the way I like to write my Rails app. There are many application templates, but this one is mine.

#### What's with the German gibberish name?

I'm so glad you asked. The [Schienenzeppelin](https://en.wikipedia.org/wiki/Schienenzeppelin) was an experimental railcar which was briefly in operation during the 1930s. It was pretty fast, and it ran on Rails. Get it? :zany_face:
