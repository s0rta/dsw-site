/* eslint-env node */

const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// Add a ProvidePlugin for jQuery
environment.plugins.set('Provide',  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery'
  })
)

const config = environment.toWebpackConfig()

config.resolve.alias = {
  jquery: 'jquery/src/jquery'
}

// export the updated config
module.exports = environment
