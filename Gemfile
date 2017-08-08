source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.1.0'
gem 'rake'
gem 'pg'
gem 'puma'

gem 'jquery-rails'
gem 'haml-rails'
gem 'slim-rails'
gem 'bourbon'
gem 'sass-rails'
gem 'coffee-rails'
gem 'underscore-rails'
gem 'uglifier'
gem 'responders'
gem 'navigasmic'
gem 'font_assets'
gem "autoprefixer-rails"

# Simple transparent captchas
gem 'honeypot-captcha', github: 'RandieM/honeypot-captcha', branch: 'master'

gem 'simple_form'
gem 'kaminari'

gem 'emma', github: 'myemma/EmmaRuby'

gem 'omniauth'
gem 'omniauth-linkedin'
gem 'devise'

gem 'html-pipeline', require: 'html/pipeline'
gem 'commonmarker'
gem 'sanitize'
gem 'rinku'
gem 'gemoji'
gem 'liquid'

gem 'textacular'

gem 'icalendar'

gem 'premailer-rails'

# State machines
gem 'simple_states'

# API
gem 'active_model_serializers', '~> 0.8.0'

# Production support
gem 'utf8-cleaner'
gem 'newrelic_rpm'
gem 'honeybadger'

gem 'rack-canonical-host'

# Admin interface
gem 'activeadmin', '~> 1.0.0'
gem 'activeadmin-ajax_filter'
# gem 'meta_search',   '>= 1.1.0.pre'
gem 'paper_trail'

# Feature toggle
gem 'redis-objects'

# Background processing
gem 'sucker_punch'

group :development do
  gem 'listen'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.6.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'selenium-webdriver', '~> 2.53'
  gem 'database_cleaner'
  gem 'email_spec', '~> 2.1.0'
  gem 'webmock'
  gem 'factory_girl_rails'
  gem 'rspec-rails-time-metadata'
end

group :production do
  gem 'rack-timeout'
  gem 'lograge'
  gem 'memcachier'
  gem 'dalli'
end
