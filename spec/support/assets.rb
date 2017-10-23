RSpec.configure do |config|
  config.before(:suite) do
    # Precompile assets so our first test doesn't time out
    # http://code.dblock.org/2013/08/04/precompiling-rails-assets-before-rspeccapybara-integration-tests.html
    message = 'Precompiling assets to preempt Capybara timeout issues'
    ms = Benchmark.ms do
      Webpacker.compile
      assets = Rails.application.config.assets.precompile
      ActionView::Base.assets_manifest.compile(assets)
    end
    puts '%s (%.1fms)' % [ message, ms ]
  end
end
