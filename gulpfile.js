// var requireDir = require('require-dir')
var plumber = require('gulp-plumber')
var gulp = require('gulp')
,   sass = require('gulp-sass')
,   sourcemaps = require('gulp-sourcemaps')
,   prefix = require('gulp-autoprefixer')
,   concat = require('gulp-concat')

// Set the Bonfire theme name
var themeTemplate = 'default'

// set up default routing for AngularBonfire
var config = {
	templatePath : './public/themes/'+themeTemplate+'/assets',
	modulesPath  : './application/modules/**/assets'
}
// Require all tasks in gulp/tasks, including subfolders
// requireDir('gulp/tasks', { recurse: true })

gulp.task('sass', function() {
	// accepts an array of paths, with a second argument being an object in which the base path is set
	// currently set to include all files from each module, and then add compiled manifest
	gulp.src([config.modulesPath+'/sass/**.*', config.templatePath+'/sass/manifest.*'], {base: './'})
	// This give us error handling, it fixes pipes
	.pipe(plumber())
	// Sass command with argument object
	.pipe(sass({
		errLogToConsole: true}
	))
	// Automatically generates vendor prefixes
	.pipe(prefix('last 2 version', '> 1%', 'ie 8', 'ie 9'))
	// .pipe(concat('style.css'))
	.pipe(gulp.dest(config.templatePath + '/css'));
})



// Watch scss folder for changes
gulp.task('watch', function() {
  // Watches the scss folder for all .scss and .sass files
  // If any file changes, run the sass task
  gulp.watch([config.modulesPath+'/sass/**.*', config.templatePath+'/sass/**.*'], ['sass'])
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
