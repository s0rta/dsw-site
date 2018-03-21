# Denver Startup Week
[![Build Status](https://travis-ci.org/denverstartupweek/dsw-site.svg?branch=master)](https://travis-ci.org/denverstartupweek/dsw-site)

### Set Up

Clone down this repository
Run `$ gem install bundler` if you don't have the ruby bundler
Run `bundle` to install dependencies.  
`yarn install`

Copy `.env.example` to your own `.env` file. `.env.example` is already
pre-populated with dummy environment variables that are sufficient for local
development and testing.

#### Get the Server Running

Make sure PostgresSQL is running and run `rake db:setup` to run migrations locally
Run `bundle exec rails s` to run the server


#### Get the Tests Running

You will need to use an older verison of Firefox to run the tests because newer versions of Firefox are incompatible with Selenium. To install the older version of Firefox, run these commands:
`brew tap goldcaddy77/homebrew-firefox`
`brew cask install firefox-46`
Once the older verison of Firefox is installed, you may have to rename it in your Applications folder from "Firefox-46" to "Firefox".

Run `$ brew install redis` to install redis library
`$ redis-server`
Run `rake db:test:prepare` to set up test database

To run the tests run one of these commands:
`bundle exec rspec` or `bundle exec rake`

## Talk Nerdy To Me
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

## License
MIT
