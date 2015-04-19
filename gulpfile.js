var gulp = require('gulp')
,   sass = require('gulp-sass')
,   sourcemaps = require('gulp-sourcemaps')
,   prefix = require('gulp-autoprefixer')

gulp.task('sass', function() {
	gulp.src('./application/modules/**/assets/sass/*.{scss,sass}')
	.pipe(sass())
	.pipe(prefix('last 2 version', '> 1%', 'ie 8', 'ie 9'))
	.pipe(gulp.dest('./css'));
})

// Watch scss folder for changes
gulp.task('watch', function() {
  // Watches the scss folder for all .scss and .sass files
  // If any file changes, run the sass task
  gulp.watch('./scss/**/*.{scss,sass}', ['sass'])
})

// Creating a default task
gulp.task('default', ['sass', 'watch']);

// /* include plugins */
// var gulp = require('gulp'),
//     sass  = require('gulp-sass'),
//     cmq = require('gulp-combine-media-queries'),
//     minifyCSS = require('gulp-minify-css'),
//     gulpif  = require('gulp-if');

// /* set variables for local/deployment/live */
// var isDev  = argv.type === 'dev',
//     isDeployment  = argv.type === 'depl',
//     isLive = argv.type === 'live';

// gulp.task('sass', function() {
//     gulp.src('./scss/**/*.{scss,sass}')
//         // compile sass, combine media queries, autoprefix and minify
//         .pipe(sass({ imagePath: '../img', sourceComments: null}))
//         .pipe(cmq())
//         .pipe(prefix('last 2 version', '> 1%', 'ie 8', 'ie 9'))
//         .pipe(gulpif(!isDev, minifyCSS({keepBreaks: false})))
//         .pipe(gulp.dest('./css'));
// });
