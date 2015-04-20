// var requireDir = require('require-dir')
var plumber = require('gulp-plumber')
var gulp = require('gulp')
,   sass = require('gulp-sass')
,   sourcemaps = require('gulp-sourcemaps')
,   prefix = require('gulp-autoprefixer')
,   concat = require('gulp-concat')
,   order = require('gulp-order')

// Set the Bonfire theme name
var themeTemplate = 'default'

// set up default routing for AngularBonfire
var config = {
	templatePath : './public/themes/'+themeTemplate+'/assets',
	assetsPath   : './public/assets/bower_components',
	modulesPath  : './application/modules/**/assets',
	jsGlobOrder  : [ // You can add your own dependancies here as you build out your app
	    "public/assets/bower_components/angular/angular.js",
	    "public/assets/bower_components/angular-ui/build/angular-ui.js",
	    "public/assets/bower_components/angular-animate/angular-animate.js",
    	"public/themes/template/ng/angular-bonfire.js",
    	"public/themes/"+themeTemplate+"/template/ng/*.js",
    	"application/modules/**/ng/**.js",
	]
}
// Require all tasks in gulp/tasks, including subfolders
// requireDir('gulp/tasks', { recurse: true })

gulp.task('sass', function() {
	// accepts an array of paths, with a second argument being an object in which the base path is set
	// currently set to include all files from each module, and then add compiled manifest
	gulp.src([
		config.modulesPath+'/sass/**.*', 
		// config.assetsPath+'/css/bootstrap.css',
		config.templatePath+'/sass/manifest.*'], {base: './'})
	// This give us error handling, it fixes pipes
	.pipe(plumber())
	// Sass command with argument object
	.pipe(sass({
		errLogToConsole: true}
	))
	// Automatically generates vendor prefixes
	.pipe(prefix('last 2 version', '> 1%', 'ie 8', 'ie 9'))
	.pipe(concat('angular-bonfire.css'))
	.pipe(gulp.dest(config.templatePath + '/css'));
})

gulp.task('ng-bonfire', function() {
	// accepts an array of paths, with a second argument being an object in which the base path is set
	// currently set to include all files from each module, and then add compiled manifest
	gulp.src([
		config.templatePath+'/ng/**.**',
		config.assetsPath+'/css/bootstrap.css',
		config.modulesPath+'/ng/**.*' 
		]
		// config.assetsPath+'/css/bootstrap.css',
		, {base: './'})
	// This give us error handling, it fixes pipes
	.pipe(plumber())
	// Stops gulp from ordering them alphabetically
	.pipe(order(config.jsGlobOrder)) //, { base: './' }))
	// Automatically generates vendor prefixes
	.pipe(concat('angular-bonfire.js'))
	.pipe(gulp.dest(config.templatePath + '/js'));
})

// Watch scss folder for changes
gulp.task('watch', function() {
  // Watches the sass folders for all .scss and .sass files
  // If any file changes, run the sass task
  gulp.watch([config.modulesPath+'/sass/**.*', config.templatePath+'/sass/**.*'], ['sass'])
  // If any file changes, run the ng-bonfire task
  gulp.watch([config.modulesPath+'/ng/**.*', config.templatePath+'/ng/**.*'], ['ng-bonfire'])
})

// Creating a default task
gulp.task('default', ['sass', 'ng-bonfire', 'watch']);