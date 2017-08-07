RSpec.configure do |config|
  config.before(:each, type: :feature) do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  config.before(:each, type: :request) do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end
end
