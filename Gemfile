source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '~> 4.2.5.2'
gem 'rake'
gem 'pg'

gem 'rails4_upgrade'

gem 'jquery-rails'
gem 'jquery-rails-cdn'
gem 'haml-rails'
gem 'slim-rails'
gem 'responders'
gem 'cmsimple', github: 'modeset/cmsimple'
gem 'mercury-rails', github: 'jejacks0n/mercury'
gem 'navigasmic'
gem 'turbolinks', github: 'rails/turbolinks' # Get the edge version for `data-turbolinks-eval`
gem 'font_assets'

gem 'temporal-rails'

# Simple transparent captchas
gem 'honeypot-captcha'

gem 'cloudinary'
gem 'simple_form'

gem 'emma', github: 'myemma/EmmaRuby'

gem 'omniauth'
gem 'omniauth-linkedin'
gem 'devise'

gem 'html-pipeline', require: 'html/pipeline'
gem 'github-markdown'
gem 'sanitize'
gem 'rinku'
gem 'gemoji'

gem 'multi_fetch_fragments'

gem 'icalendar'

gem 'mail_view', github: 'basecamp/mail_view'
gem 'premailer-rails'

# State machines
gem 'simple_states'

# API
gem 'active_model_serializers', '~> 0.8.0'

# Production support
gem 'utf8-cleaner'
gem 'rollbar', '~> 1.2.7'
gem 'newrelic_rpm'

gem 'rack-canonical-host'

# Admin interface
gem 'activeadmin', '>=1.0.0.pre2'
# gem 'meta_search',   '>= 1.1.0.pre'
gem 'paper_trail'

# Feature toggle
gem 'redis-objects'

# Background processing
gem 'sucker_punch'

group :assets do
  gem 'bourbon'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'underscore-rails'
  gem 'uglifier'
  # gem 'utensils', github: 'modeset/utensils'
  # gem 'turbo-sprockets-rails3', github: 'ndbroadbent/turbo-sprockets-rails3'
end

group :development do
  gem 'spring', require: false
  gem 'spring-commands-rspec', require: false
  gem 'dotenv-rails'
end

group :development, :test do
  gem 'thin'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'teaspoon'
  gem 'quiet_assets'
end

group :test do
  gem 'test-unit', '~> 3.0'
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'lograge'
  gem 'memcachier'
  gem 'dalli'
end
