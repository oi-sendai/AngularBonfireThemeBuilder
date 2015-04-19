#!/bin/sh

args=("$@")

echo Theme name: $#
echo Your them ctrl-x to quit: ${args[1]}
echo Module name: $#
echo Your them ctrl-x to quit: ${args[1]}
THEME=${args[2]}
MODULE=${args[1]}

# create module sass and js
mkdir -p application/modules/angularbonfire/assets/ng
echo 'console.log(your module js)' > application/modules/angularbonfire/ng/your-module.js
mkdir -p application/modules/angularbonfire/assets/sass
echo ".your-module h1 { transform: translate(50px,100px);} " > application/modules/angularbonfire/assets/sass/your-module.scss

# create the theme js files
echo "console.log('angular-bonfire.js)" > public/themes/angularbonfire/assets/ng/angular-bonfire.js
echo "console.log('your module js)" > public/themes/angularbonfire/assets/ng/your-app.js

# create the theme sass files
mkdir -p public/themes/angularbonfire/assets/sass
echo "@import 'partial'" > public/themes/angularbonfire/assets/sass/manifest.scss
echo ".angularbonfire {colorL:#778899;} /* build complete */" > public/themes/angularbonfire/assets/sass/_partial.scss




## add theme and module to existing bonfire .gitignore
echo "# AngularBonfire ignores" >> .gitignore
echo "node_modules" >> .gitignore
echo "public/assets/bower_components" >> .gitignore
#echo "## discussion point / qa want production environment, marketing want it shipped" >> .gitignore
#echo "public/themes/angular-bonfire/assets/css/*" >> .gitignore
#echo "public/themes/angular-bonfire/assets/js" >> .gitignore

echo "# AngularBonfire includes" >> .gitignore
echo "!public/themes/angular-bonfire/*" >> .gitignore
echo "!application/modules/yourmodulezxas/yourapp/*" >> .gitignore

echo "!gulpfile.js"
echo "!bower.json"
echo "!package.json"

read -p "Remove this installation script from project?" choice
case "$choice" in 
  y|Y ) echo "!create-theme.sh"; echo "removed file";;
  n|N ) rm create-theme.sh;;
  * ) echo "invalid";;
esac

read "your theme has now been installed. Run 'bower install && npm install && gulp' to start debugging your project"