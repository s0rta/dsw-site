worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 10
preload_app true
listen ENV['PORT'].to_i || 3000, tcp_nopush: false

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  if defined?(Redis)
    Redis.current.quit
  end

end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  # Duplicated in config/initializers/redis.rb
  if defined?(Redis)
    url = ENV['REDISCLOUD_URL'] || ENV['MYREDIS_URL'] || ENV['REDISTOGO_URL' || ENV['REDIS_URL']]
    if url
      uri = URI.parse(url)
      Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
      Rails.logger.info('Connected to Redis')
    end
  end

  # Reset the object cache store (Dalli)
  if Rails.cache.respond_to?(:reset)
    Rails.cache.reset
    Rails.logger.info('Rails cache has been reset')
  end

  # Reconfigure the DB connection pool
  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'].to_i || 10 # seconds
    config['pool']              = ENV['DB_POOL'].to_i || 5
    ActiveRecord::Base.establish_connection(config)
  end

end
