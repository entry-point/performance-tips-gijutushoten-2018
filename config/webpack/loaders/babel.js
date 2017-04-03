module.exports = {
  test: /\.js(\.erb)?$/,
  exclude: /node_modules/,
  loader: 'babel-loader',
  options: {
    presets: [
      [ 'es2016' ],
      ['env', { modules: false }]
    ]
  }
}
