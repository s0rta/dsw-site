source 'https://rubygems.org'

ruby '2.5.1'

gem 'bootsnap'
gem 'mime-types', '>= 2.6.1', require: 'mime/types/columnar'
gem 'pg'
gem 'puma'
gem 'puma_worker_killer'
gem 'rails', '~> 5.2.0'
gem 'rake'

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

gem 'carrierwave'
gem 'commonmarker'
gem 'devise'
gem 'fog-aws'
gem 'gemoji'
gem 'gravatarify'
gem 'html-pipeline', require: 'html/pipeline'
gem 'liquid'
gem 'mini_magick'
gem 'rinku'
gem 'sanitize'

gem 'premailer-rails'
gem 'retries'
gem 'sendgrid', github: 'caring/sendgrid'
gem 'sendgrid-ruby'

# State machines
gem 'simple_states'

# API
gem 'active_model_serializers', '~> 0.8.0'

# Production support
gem 'honeybadger'
gem 'newrelic_rpm'
gem 'skylight'
gem 'rack-canonical-host'
gem 'utf8-cleaner'

# Admin interface
gem 'activeadmin'
gem 'activeadmin-ajax_filter', '>= 0.3.7', github: 'jayzes/activeadmin-ajax_filter'
gem 'paper_trail'
gem 'validate_url'

# Background processing
gem 'sidecloq'
gem 'sidekiq'
gem 'sidekiq-throttled'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'factory_bot_rails'
  gem 'rspec-rails-time-metadata'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock', require: false
end

group :production do
  gem 'dalli'
  gem 'heroku-deflater'
  gem 'lograge'
  gem 'memcachier'
  gem 'rack-timeout'
end
