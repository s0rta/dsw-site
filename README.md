# Denver Startup Week
[![Build Status](https://travis-ci.org/denverstartupweek/dsw-site.svg?branch=master)](https://travis-ci.org/denverstartupweek/dsw-site)

### Dependencies
These set up instructions assume that you already have the following installed:
- Bundler
- Yarn
- Redis
- PostgreSQL

Fork this repository and run `bundle` to install Ruby dependencies.

Run `bin/yarn install` to install Webpacker/JS dependencies.

Copy `.env.example` to your own `.env` file. `.env.example` is already
pre-populated with dummy environment variables for local
development and testing.

#### Set Up

Ensure PostgreSQL is running and run `rake db:setup` to set up a development
database and run migrations locally.

Start the Redis server with `redis-server`.

Run `bundle exec rails s` to run the Rails server.

#### Running Tests

You will need Chrome and Chromedriver to run the tests, which you can install with Homebrew:

```
brew cask install google-chrome chromedriver
```

Run `rake db:test:prepare` to set up your test database.

Run the test suite with `bundle exec rspec`.

## Contributing
Denver Startup Week is a community-run event and we welcome contributions in
this same spirit. We do ask that you review the [Contribution
Guidelines](./contributing.md) before submitting a pull request.

#### Code of Conduct
All contributors and contributions must adhere to the [Denver Startup Week Code of
Conduct](https://www.denverstartupweek.org/code-of-conduct).

## Talk Nerdy To Me
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

## License
MIT
