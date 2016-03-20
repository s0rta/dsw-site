# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << 'app/assets'
Rails.application.config.assets.paths << 'app/assets/fonts'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(cmsimple.js cmsimple.css mercury.css polyfill.js dinosaur.css respond.proxy.js respond-proxy.html jquery.js active_admin.css active_admin.js active_admin/print.css basecamp.css basecamp.js daily_schedule_email.css emoji/*.png *.otf)
