gulp = require 'gulp'
paths = require './gulp/config/paths.coffee'

general =
  clean: (directory, callback) -> require('./gulp/tasks/clean.coffee')(directory, callback)
  concat: (sourceFiles, filename, dest) -> require('./gulp/tasks/concat.coffee')(sourceFiles, filename, dest)
  test: () -> require('./gulp/tasks/test.coffee')(paths.vendor)
  webserver: (serverRoot) -> require('./gulp/tasks/webserver.coffee')(serverRoot)
  templateCache: (sourceFiles, dest) -> require('./gulp/tasks/templateCache.coffee')(sourceFiles, dest)
  copy: (sourceFiles, dest, options) ->require('./gulp/tasks/copy.coffee')(sourceFiles, dest, options)

build =
  copyVendor: () -> require('./gulp/tasks/copy.coffee')(paths.vendor, paths.build.directories.base)
  coffee: () -> require('./gulp/tasks/coffee.coffee')(paths.coffee.build, paths.build.directories.base)
  copyHtml: () -> require('./gulp/tasks/copy.coffee')(paths.html.files, paths.build.directories.base)
  inject: () -> require('./gulp/tasks/injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor.js,  paths.build.directories.base)
  webserver: () -> require('./gulp/tasks/webserver.coffee')(paths.build.directories.base)

compile =
  minifyCoffeeToJs: () -> require('./gulp/tasks/minifyCoffeeToJs.coffee')(paths.coffee.compile, 'angular-stacktrace', paths.dist.directories.base)

# Test tasks
gulp.task 'test', () -> general.test()

# Build tasks
gulp.task 'b-clean', (callback) -> general.clean(paths.build.directories.base, callback)
gulp.task 'b-copyVendor', ['b-clean'], () -> general.copy(paths.vendor.js, paths.build.directories.base)
gulp.task 'b-coffee', ['b-clean'], () -> build.coffee()
gulp.task 'b-copyFonts', ['b-clean'], () -> general.copy(paths.vendor.fonts, paths.build.directories.fonts, {})
gulp.task 'b-copyHtml', ['b-clean'], () -> general.copy(paths.html.files, paths.build.directories.base)
gulp.task 'b-inject', ['b-clean', 'b-copyVendor', 'b-coffee'], () -> build.inject()
gulp.task 'b-webserver', ['b-clean', 'b-copyVendor', 'b-coffee',  'b-inject'], () -> general.webserver(paths.build.directories.base)
gulp.task 'build', ['b-clean',  'b-copyVendor', 'b-coffee', 'b-inject', 'b-webserver'], () ->
  require('./gulp/tasks/buildWatch.coffee')(paths.coffee, paths.build.directories.js)

# compile tasks
minifiedFiles = ['vendor.js', 'scripts.js', 'templates.js'].map (filename) -> paths.dist.directories.tmp + filename
gulp.task 'c-clean', (callback) -> general.clean(paths.dist.directories.base, callback)
gulp.task 'c-minifyCoffeeToJS', ['c-clean'], () -> compile.minifyCoffeeToJs()
gulp.task 'c-concat', ['c-clean', 'c-minifyCoffeeToJS',], () -> general.concat(minifiedFiles, 'angular.js', paths.dist.directories.js)
gulp.task 'compile', ['c-clean', 'c-minifyCoffeeToJS', 'c-concat']