const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default'],
    moment: 'moment',
    dropzone: 'dropzone'
  })
)

module.exports = environment
