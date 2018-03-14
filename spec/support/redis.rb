RSpec.configure do |c|
  c.before(:each, redis: true) do
    Redis.current.flushdb
  end
end
