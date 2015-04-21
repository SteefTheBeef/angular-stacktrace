gulp = require 'gulp'
paths = require '../config/paths.coffee'

module.exports = () ->
  console.log 'Watching for .coffee, .less and .html file changes.'

  gulp.task 'b-watchHtml', -> require('./copy.coffee')(paths.html.files, paths.build.directories.base)
  gulp.watch(paths.html.watch + '/**/*', ['b-watchHtml'])

  gulp.task 'index', ['coffee'] ,-> require('./injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor.js, paths.build.directories.base)
  gulp.watch(paths.index, ['index'])

  gulp.task 'coffee', -> require('./coffee.coffee')(paths.coffee.build, paths.build.directories.base)
  gulp.task 'indexInjectCoffee', ['coffee'] ,-> require('./injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor.js, paths.build.directories.base)
  gulp.watch(paths.coffee.base + '/**/*', ['indexInjectCoffee'])