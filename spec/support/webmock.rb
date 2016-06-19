require 'algolia/webmock'

RSpec.configure do |c|
  c.before(:each) do
    WebMock.enable!
  end

  c.after(:each) do
    WebMock.disable!
  end
end
