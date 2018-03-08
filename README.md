# Denver Startup Week
[![Build Status](https://travis-ci.org/denverstartupweek/dsw-site.svg?branch=master)](https://travis-ci.org/denverstartupweek/dsw-site)

### Set Up
Clone this repository and `bundle` to install dependencies.

Copy `.env.example` to your own `.env` file. `.env.example` is already
pre-populated with dummy environment variables that are sufficient for local
development and testing.

Ensure PostgreSQL is running and `rake db:setup` to run migrations locally. Run
the server with `bundle exec rails s`.

To set up a test database, `rake db:test:prepare` and `bundle exec rspec` or
`bundle exec rake` to run the tests.

You will need to use an older version of Firefox to run tests since the newer
versions of Firefox are incompatible with Selenium. The CI suite specifies
Firefox 46, which you can obtain via Brew Cask:
```
brew tap goldcaddy77/homebrew-firefox
brew cask install firefox-46
```

## Talk Nerdy To Me
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

## License
MIT
