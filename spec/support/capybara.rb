require "capybara/rails"
require "capybara/rspec"

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu])

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {"w3c" => false},
  )
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities)
end

Capybara.default_driver = :chrome

RSpec.configure do |config|
  config.prepend_before(:each, type: :feature) do
    Capybara.reset_session!
    if Capybara.current_session.driver.browser.respond_to?(:manage)
      Capybara.current_session.driver.browser.manage.window.resize_to(1440, 768)
    end
  end
end
