# Schienenzeppelin

Schienenzeppelin is an opinionated Ruby on Rails template. It is  ̶a̶̶̶ ̶̶̶s̶̶̶h̶̶̶a̶̶̶m̶̶̶e̶̶̶l̶̶̶e̶̶̶s̶̶̶s̶̶̶ ̶̶̶r̶̶̶i̶̶̶p̶̶̶-̶̶̶o̶̶̶f̶̶̶f̶̶̶ ̶̶̶o̶̶̶f̶̶̶ inspired by [Suspenders](https://github.com/thoughtbot/suspenders).

![zeppelin](./schienenzeppelin.jpg)

## Getting Started

Install the schienenzeppelin gem: 

```
gem install schienenzeppelin
```

Then run:

```
schienenzeppelin new <project-name>
```

See [Usage](#usage) for details.

## What's included? 

Per default, Schienenzeppelin will be configured using a set of customized options for development, testing and production use of your application. Here are some highlights: 

### Production

- Tailwind CSS
- High Voltage
- Skylight
- Sidekiq
- Oj
- JBuilder
- PostgreSQL
- Honeybadger
- Hotwire
- Rack Mini Profiler

### Development
- `.irbrc` configuration
- `bin/setup` script
- Dotenv
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
