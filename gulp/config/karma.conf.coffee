module.exports = (config) ->
  config.set
    preprocessors: {
      '../../src/**/*.coffee': ['coffee']
    },
    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      },
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')
    }
    basePath: ''
    files: [
      '../../bower_components/angular/angular.js'
      '../../bower_components/angular-mocks/angular-mocks.js'
      '../../src/config/registerModules.coffee'
      '../../src/**/*.coffee'
      '../../src/**/*.spec.coffee'
    ],
    frameworks: ['jasmine']
    browsers: ['PhantomJS']
    port: 9876,
    captureTimeout: 20000,
    singleRun: false,
    reportSlowerThan: 500
    LogLevel: config.LOG_DEBUG,
    plugins: [
      'karma-browserify'
      'karma-jasmine'
      'karma-chrome-launcher'
      'karma-phantomjs-launcher'
      'karma-coffee-preprocessor'
    ]
