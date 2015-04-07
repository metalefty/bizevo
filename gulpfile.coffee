gulp       = require 'gulp'
rename     = require 'gulp-rename'
plumber    = require 'gulp-plumber'
concat     = require 'gulp-concat'
sass       = require 'gulp-sass'
bowerFiles = require 'main-bower-files'
source     = require 'vinyl-source-stream'
browserify = require 'browserify'
bower      = require 'gulp-bower'
gulpFilter = require 'gulp-filter'

gulp.task 'js', ->
  browserify
    entries: ['./public/javascripts/initialize.coffee']
    extensions: ['.coffee','.jade', '.js']
  .transform 'coffeeify'
  .transform 'jadeify'
  .bundle()
  .pipe plumber()
  .pipe source 'app.js'
  .pipe gulp.dest 'public'

gulp.task 'vendor', ->
  jsFilter = gulpFilter '**/*.js'
  gulp.src(bowerFiles())
  .pipe jsFilter
  .pipe plumber()
  .pipe concat('vendor.js')
  .pipe gulp.dest('./public/javascripts')

gulp.task 'css', ->
  gulp
  .src './app/styles/*.scss'
  .pipe plumber()
  .pipe sass()
  .pipe gulp.dest './public/stylesheets'
  gulp
  .src 'bower_components/semantic/dist/semantic.min.css'
  .pipe gulp.dest './public/stylesheets'
  gulp
  .src 'bower_components/semantic/dist/themes/**/*'
  .pipe gulp.dest './public/stylesheets/themes'

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/**/*.coffee', ['js']
  gulp.watch 'app/**/*.jade', ['js']
  gulp.watch 'app/styles/**/*.scss', ['css']
  gulp.watch 'bower_components/**/*.js', ['vendor']

gulp.task 'bower', ->
  bower {cmd: 'update'}
gulp.task 'build', ['vendor', 'js', 'css']
gulp.task 'default', ['build']