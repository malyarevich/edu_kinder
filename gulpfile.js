// include the required packages. 
var gulp = require('gulp');
var stylus = require('gulp-stylus');
 
// include, if you want to work with sourcemaps 
var sourcemaps = require('gulp-sourcemaps');

 // External sourcemaps 
gulp.task('css', function () {
  return gulp.src('./docs/stylus/main.styl')
    .pipe(sourcemaps.init())
    .pipe(stylus())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./docs/css/'));
});

gulp.task('all:watch', function () {
    gulp.watch('./docs/stylus/**/*.styl', ['css']);
});

gulp.task('default', [ 'css', 'all:watch' ]);