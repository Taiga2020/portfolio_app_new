const { environment } = require('@rails/webpacker')

/*
 const webpack = require('webpack')
 environment.plugins.prepend('Provide',
   new webpack.ProvidePlugin({
     $: 'jquery/src/jquery',
     jQuery: 'jquery/src/jquery',
     Popper: ['popper.js', 'default']
   })
 )
*/

// エイリアスの設定をする
environment.toWebpackConfig().merge({
 resolve: {
     alias: {
              'jquery': 'jquery/src/jquery'
            }
          }
});

module.exports = environment
