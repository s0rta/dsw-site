RSpec.configure do |config|
  config.before(:suite) do
    # Precompile assets so our first test doesn't time out
    # http://code.dblock.org/2013/08/04/precompiling-rails-assets-before-rspeccapybara-integration-tests.html
    message = "Precompiling assets to preempt Capybara timeout issues"
    webpacker_ms = Benchmark.ms {
      Webpacker.compile
    }
    warn "Webpacker: %s (%.1fms)" % [message, webpacker_ms]
    ms = Benchmark.ms {
      assets = Rails.application.config.assets.precompile
      ActionView::Base.assets_manifest.compile(assets)
    }
    warn "Pipeline: %s (%.1fms)" % [message, ms]
  end
end
