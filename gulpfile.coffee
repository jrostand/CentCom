gulp = require 'gulp'

bowerFiles = require 'main-bower-files'
coffee = require 'gulp-coffee'
coffeeLint = require 'gulp-coffeelint'
concat = require 'gulp-concat'
flatten = require 'gulp-flatten'
lintStylish = require 'coffeelint-stylish'
sass = require 'gulp-sass'

build =
  css: 'public/css/'
  fonts: 'public/fonts/'
  js: 'public/js/'

sources =
  coffee:
    app: 'assets/js/*.coffee'
    lib: 'assets/js/lib/*.coffee'
  fonts: 'assets/fonts/*'
  scss: 'assets/css/*.scss'

gulp.task 'bower:css', ->
  gulp.src(bowerFiles('**/*.css'), base: 'bower_components/')
    .pipe(concat('vendor.css'))
    .pipe(gulp.dest build.css)

gulp.task 'bower:fonts', ->
  gulp.src(bowerFiles('**/*.{eot,svg,ttf,woff,woff2}'), base: 'bower_components/')
    .pipe(flatten())
    .pipe(gulp.dest build.fonts)

gulp.task 'bower:js', ->
  gulp.src(bowerFiles('**/*.js'), base: 'bower_components/')
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest build.js)

gulp.task 'bower', ['bower:css', 'bower:fonts', 'bower:js']

gulp.task 'coffee', ->
  gulp.src([sources.coffee.lib, sources.coffee.app])
    .pipe(coffeeLint '.coffeelint.json')
    .pipe(coffeeLint.reporter(lintStylish))
    .pipe(coffee())
    .pipe(concat('all.js'))
    .pipe(gulp.dest build.js)

gulp.task 'fonts', ->
  gulp.src(sources.fonts)
    .pipe(gulp.dest build.fonts)

gulp.task 'sass', ->
  gulp.src(sources.scss)
    .pipe(sass().on 'error', sass.logError)
    .pipe(gulp.dest build.css)

gulp.task 'watch', ->
  gulp.watch 'bower_components/', ['bower']
  gulp.watch [sources.coffee.app, sources.coffee.lib], ['coffee']
  gulp.watch sources.fonts, ['fonts']
  gulp.watch sources.scss, ['sass']

gulp.task 'default', ['bower', 'sass', 'fonts', 'coffee']
