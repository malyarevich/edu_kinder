// include the required packages. 
var gulp = require('gulp');
var stylus = require('gulp-stylus');
 
// include, if you want to work with sourcemaps 
var sourcemaps = require('gulp-sourcemaps');

 // External sourcemaps 
gulp.task('css', function () {
  return gulp.src('./public/stylus/main.styl')
    .pipe(sourcemaps.init())
    .pipe(stylus())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public/css/'));
});

gulp.task('all:watch', function () {
    gulp.watch('./public/stylus/**/*.styl', ['css']);
});

gulp.task('default', [ 'css', 'all:watch' ]);