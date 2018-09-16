source 'https://rubygems.org'

ruby '2.3.4'

gem 'mime-types', '>= 2.6.1', require: 'mime/types/columnar'
gem 'rails', '~> 5.1.0'
gem 'rake'
gem 'pg'
gem 'puma'

gem 'autoprefixer-rails'
gem 'font_assets'
gem 'sassc-rails'
gem 'slim-rails'
gem 'uglifier'
gem 'webpacker'

gem 'httparty'
gem 'icalendar'
gem 'jsonb_accessor'
gem 'responders'
gem 'textacular'

# Simple transparent captchas
gem 'honeypot-captcha', github: 'RandieM/honeypot-captcha', branch: 'master'

gem 'devise'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'gravatarify'
gem 'html-pipeline', require: 'html/pipeline'
gem 'commonmarker'
gem 'sanitize'
gem 'rinku'
gem 'gemoji'
gem 'liquid'

gem 'premailer-rails'
gem 'sendgrid', github: 'caring/sendgrid'
gem 'sendgrid-ruby'
gem 'retries'

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
gem 'activeadmin'
gem 'activeadmin-ajax_filter', '>= 0.3.7', github: 'jayzes/activeadmin-ajax_filter'
gem 'paper_trail'
gem 'validate_url'

# Background processing
gem 'sidekiq'
gem 'sidekiq-throttled'
gem 'sidecloq'

group :development do
  gem 'listen'
  gem 'better_errors'
  gem 'binding_of_caller'
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
  gem 'vcr'
  gem 'webmock', require: false
  gem 'factory_bot_rails'
  gem 'rspec-rails-time-metadata'
end

group :production do
  gem 'rack-timeout'
  gem 'lograge'
  gem 'memcachier'
  gem 'dalli'
  gem 'heroku-deflater'
end
