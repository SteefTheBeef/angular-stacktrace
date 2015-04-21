obj =
  build:
    directories:
      base: 'build/'
      js: 'build/app/'
      vendor: 'build/vendor/'
      css: 'build/assets/css/'
      fonts: 'build/assets/fonts/'
  dist:
    directories:
      base: 'dist/'
      tmp: 'dist/.tmp/'
      js: 'dist/js/'
      css: 'dist/css/'
  vendor:
    js: [
      'bower_components/jquery/dist/jquery.js'
      'bower_components/stacktrace-js/stacktrace.js'
      'bower_components/angular/angular.js'
    ]
  coffee:
    base: 'src/'
    build: [
      'src/traceService.coffee'
      'src/register.coffee'
      'src/app.coffee'
    ]
    compile: [
      'src/traceService.coffee'
    ]
  inject: {}
  index: './index.html'
  html:
    watch: 'src/**/*'
    files: './src/**/*.html'
    tpl: 'src/**/*.tpl.html'

obj.inject.coffeeToJs = () ->
  obj.coffee.build.map (filename) ->
    obj.build.directories.base + filename.replace('.coffee', '.js')

module.exports = obj