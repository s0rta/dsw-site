# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

GC::Profiler.enable

if ENV['CANONICAL_HOST']
  use Rack::CanonicalHost,
    ENV['CANONICAL_HOST'],
    ignore: (ENV['CANONICAL_HOST_IGNORE'] || '').split(','),
    cache_control: 'no-cache'
end
run Denverstartupweek::Application
