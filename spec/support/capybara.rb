require "capybara/rails"
require "capybara/rspec"

Capybara.enable_aria_label = true

Capybara.register_driver :chrome do |app|
  args = %w[no-sandbox disable-gpu]
  unless ENV["NO_HEADLESS"]
    warn "Running Chrome in headless mode"
    args.push "headless"
  end
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
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
