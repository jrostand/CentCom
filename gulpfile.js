var gulp = require('gulp');

var babel = require('gulp-babel');
var bowerFiles = require('main-bower-files');
var concat = require('gulp-concat');
var flatten = require('gulp-flatten');
var sass = require('gulp-sass');

var build = {
  css: 'public/css/',
  fonts: 'public/fonts/',
  js: 'public/js/'
};

var sources = {
  fonts: 'assets/fonts/*',
  js: ['assets/js/components/*.js', 'assets/js/*.js'],
  scss: 'assets/css/*.scss'
};

gulp.task('bower:css', function() {
  return gulp.src(bowerFiles('**/*.css'), { base: 'bower_components/' })
    .pipe(concat('vendor.css'))
    .pipe(gulp.dest(build.css));
});

gulp.task('bower:fonts', function() {
  return gulp.src(bowerFiles('**/*.{eot,svg,ttf,woff,woff2}'), { base: 'bower_components/' })
    .pipe(flatten())
    .pipe(gulp.dest(build.fonts));
});

gulp.task('bower:js', function() {
  return gulp.src(bowerFiles('**/*.js'), { base: 'bower_components/' })
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest(build.js));
});

gulp.task('bower', ['bower:css', 'bower:fonts', 'bower:js']);

gulp.task('fonts', function() {
  return gulp.src(sources.fonts).pipe(gulp.dest(build.fonts));
});

gulp.task('js', function() {
  return gulp.src(sources.js)
    .pipe(babel())
    .pipe(concat('app.js'))
    .pipe(gulp.dest(build.js));
});

gulp.task('sass', function() {
  return gulp.src(sources.scss)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(build.css));
});

gulp.task('watch', function() {
  gulp.watch('bower_components/', ['bower']);
  gulp.watch(sources.fonts, ['fonts']);
  gulp.watch(sources.js, ['js']);
  gulp.watch(sources.scss, ['sass']);
});

gulp.task('default', ['bower', 'sass', 'fonts', 'js']);
