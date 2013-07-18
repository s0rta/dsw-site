require 'sprockets'

# This fix is from https://github.com/rails/rails/pull/9820 and http://stackoverflow.com/questions/15501354/what-causes-the-extreme-slowness-when-changing-from-rails-3-2-12-to-3-2-13

unless Rails.version == '3.2.13'
  raise "Rails version changed! Please remove config/initializers/asset_slowness_monkeypatch.rb as it should no longer be necessary"
end

module Sprockets
  module Helpers
    module RailsHelper
      class AssetPaths < ::ActionView::AssetPaths
        private
        def rewrite_extension(source, dir, ext)
          source_ext = File.extname(source)[1..-1]
          if !ext || ext == source_ext
            source
          elsif source_ext.blank?
            "#{source}.#{ext}"
          elsif File.exists?(source) || exact_match_present?(source)
            source
          else
            "#{source}.#{ext}"
          end
        end
      end
    end
  end
end
