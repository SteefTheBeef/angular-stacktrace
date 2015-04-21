gulp = require 'gulp'

module.exports = (sourceFiles, destination, options = { base: '.' }) ->
  gulp.src(sourceFiles, options)
  .pipe(gulp.dest(destination))