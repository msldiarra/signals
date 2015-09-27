var gulp = require('gulp');
var browserify = require('browserify');
var babelify = require('babelify');
var source = require('vinyl-source-stream');
var serve = require('gulp-serve');

gulp.task('browserify', function () {
    browserify({
        entries: './src/js/app.js',
        extensions: ['.js'],
        debug: true
    })
        .transform(babelify)
        .bundle()
        .pipe(source('app.js'))
        .pipe(gulp.dest('dist/js'));
});

gulp.task('copy',function() {
    gulp.src('src/index.html')
        .pipe(gulp.dest('dist'));
    gulp.src('src/assets/**/*.*')
        .pipe(gulp.dest('dist/assets'));
});

gulp.task('serve', serve('dist'));

gulp.task('default',['browserify', 'copy', 'serve'], function() {
    return gulp.watch('src/**/*.*', ['browserify', 'copy'])
});