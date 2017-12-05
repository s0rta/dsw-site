require 'capybara/rails'
require 'capybara/rspec'

Capybara.default_driver = :selenium
if ENV['FIREFOX_BIN_PATH']
  puts "Using vendored Firefox binary from #{ENV['FIREFOX_BIN_PATH']}"
  Capybara.register_driver :selenium do |app|
    require 'selenium/webdriver'
    Selenium::WebDriver::Firefox::Binary.path = ENV['FIREFOX_BIN_PATH']
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
end

RSpec.configure do |config|
  config.prepend_before(:each, type: :feature) do
    Capybara.reset_session!
    if Capybara.current_session.driver.browser.respond_to?(:manage)
      Capybara.current_session.driver.browser.manage.window.resize_to(1440, 768)
    end
  end
end

