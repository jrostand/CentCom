gulp = require 'gulp'

coffee = require 'gulp-coffee'
coffeeLint = require 'gulp-coffeelint'
concat = require 'gulp-concat'
# del = require 'del'
lintStylish = require 'coffeelint-stylish'
sass = require 'gulp-sass'

build =
  css: 'public/css/'
  js: 'public/js/'

sources =
  coffee:
    app: 'assets/js/*.coffee'
    lib: 'assets/js/lib/*.coffee'
  scss: 'assets/css/*.scss'

gulp.task 'coffee', ->
  gulp.src([sources.coffee.lib, sources.coffee.app])
    .pipe(coffeeLint '.coffeelint.json')
    .pipe(coffeeLint.reporter(lintStylish))
    .pipe(coffee())
    .pipe(concat('all.js'))
    .pipe(gulp.dest build.js)

gulp.task 'sass', ->
  gulp.src(sources.scss)
    .pipe(sass().on 'error', sass.logError)
    .pipe(gulp.dest build.css)

gulp.task 'default', ['sass', 'coffee']
