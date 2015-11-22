var webpack = require('webpack'),
    ExtractorPlugin = require('extract-text-webpack-plugin');

var providePlugin = new webpack.ProvidePlugin({
  $: 'jquery',
  React: 'react'
});

var cssExtractorPlugin = new ExtractorPlugin('app.css');

var loaders = [
  {
    test: /\.css$/,
    include: /node_modules/,
    loader: ExtractorPlugin.extract('style', 'css')
  },
  {
    test: /\.jsx$/,
    exclude: /(node_modules|bower_components)/,
    loader: 'babel',
    query: {
      presets: ['react']
    }
  },
  {
    test: /\.scss/,
    loader: ExtractorPlugin.extract('style', ['css', 'sass'])
  },
  {
    test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,
    loader: 'url',
    query: {
      limit: 10000,
      mimetype: 'application/font-woff',
      name: '[name].[ext]'
    }
  },
  {
    test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,
    loader: 'url',
    query: {
      limit: 10000,
      mimetype: 'application/font-woff',
      name: '[name].[ext]'
    }
  },
  {
    test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
    loader: 'url',
    query: {
      limit: 10000,
      mimetype: 'application/octet-stream',
      name: '[name].[ext]'
    }
  },
  {
    test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
    loader: 'url',
    query: {
      limit: 10000,
      mimetype: 'image/svg+xml',
      name: '[name].[ext]'
    }
  },
  {
    test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
    loader: 'file',
    query: {
      name: '[name].[ext]'
    }
  }
];

module.exports = {
  entry: './assets/js/app.jsx',
  output: {
    path: 'public/',
    filename: 'app.js'
  },
  module: {
    loaders: loaders
  },
  plugins: [
    providePlugin,
    cssExtractorPlugin
  ],
  resolve: {
    alias: {
      'font-awesome': 'font-awesome/css/font-awesome.css',
      'weather-icons-base': 'weather-icons/css/weather-icons.css',
      'weather-icons-wind': 'weather-icons/css/weather-icons-wind.css'
    }
  }
}
