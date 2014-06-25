gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'coffee', ->
    gulp.src 'app/**/*.coffee'
    .pipe do coffee
    .pipe gulp.dest('app')
