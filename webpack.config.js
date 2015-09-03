var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
    entry: './src/frontend/main.coffee',
    target: 'web',
    output: {
        path: './public/build',
        publicPath: '/build/',
        filename: "build.js"
    },
    module: {
        loaders: [
            { test: /\.woff2?$/, loader: "url-loader?limit=10000&mimetype=application/font-woff" },
            { test: /\.ttf$/,    loader: "file-loader" },
            { test: /\.eot$/,    loader: "file-loader" },
            { test: /\.svg$/,    loader: "file-loader" },
            { test: /\.coffee$/, loader: "coffee"      },
            { test: /\.html$/,   loader: "html"        },
            { test: /\.scss$/,   loader: ExtractTextPlugin.extract('style-loader', 'css-loader!sass-loader') },
        ]
    },
    resolve: {
        extensions: ['', '.js', '.coffee']
    },
    plugins: [
        new ExtractTextPlugin('styles.css')
    ]
}
