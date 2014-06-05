# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Set up Unicorn OOBGC
if defined?(Unicorn::HttpRequest)
  require 'gctools/oobgc'
  use GC::OOB::UnicornMiddleware
end

use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']
run Denverstartupweek::Application
