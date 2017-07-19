require 'capybara/rails'
require 'capybara/rspec'

Capybara.register_driver :selenium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.firefox(marionette: false)
  Capybara::Selenium::Driver.new(app,
                                 browser: :firefox,
                                 desired_capabilities: caps)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.prepend_before(:each, type: :feature) do
    Capybara.reset_session!
    if Capybara.current_session.driver.browser.respond_to?(:manage)
      Capybara.current_session.driver.browser.manage.window.resize_to(1440, 768)
    end
  end
end

