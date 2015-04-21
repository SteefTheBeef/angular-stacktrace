gulp = require 'gulp'
plumber = require 'gulp-plumber'
coffee = require 'gulp-coffee'
lint = require 'gulp-coffeelint'

ngAnnotate = require 'gulp-ng-annotate'
streamify = require('gulp-streamify')

module.exports = (sourceFiles, destination) ->
  gulp.src(sourceFiles, { base: "." })
  .pipe(plumber (err) ->
      console.log "\nCoffeeScript ERROR\n" + err + "\n"
      @emit('end')
  )
  .pipe(lint('gulp/config/coffeelint.json'))
  .pipe(lint.reporter())
  .pipe(coffee({ bare: true }))
  .pipe(ngAnnotate())
  .pipe(gulp.dest(destination))
