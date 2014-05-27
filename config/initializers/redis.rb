# Duplicated in config/unicorn.rb
if defined?(Redis)
  url = ENV['REDISCLOUD_URL'] || ENV['MYREDIS_URL'] || ENV['REDISTOGO_URL' || ENV['REDIS_URL']]
  if url
    uri = URI.parse(url)
    Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
    Rails.logger.info('Connected to Redis')
  end
end
