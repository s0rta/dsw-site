require 'capybara/rails'
require 'capybara/rspec'

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.prepend_before(:each, type: :feature) do
    Capybara.reset_session!
    if Capybara.current_session.driver.browser.respond_to?(:manage)
      Capybara.current_session.driver.browser.manage.window.resize_to(1440, 768)
    end
  end
end

