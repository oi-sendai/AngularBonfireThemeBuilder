#!/bin/sh

args=("$@")
#capture theme name and module name
echo -n "theme name:" 
read theme
echo "Your theme is called $theme. ctrl-x to quit:"
echo "module name:" 
read module
echo "Your module is called $module. ctrl-x to quit:"

# create module js
mkdir -p application/modules/$module/assets/ng
echo "console.log(your module js)" > application/modules/$module/assets/ng/$module.js

# create module sass
mkdir -p application/modules/$module/assets/sass
echo ".your-module h1 { transform: translate(50px,100px);} " >> application/modules/$module/assets/sass/$module.scss

# create the theme js files
mkdir -p public/themes/$theme/assets/ng
echo "console.log('angular-bonfire.js)" >> public/themes/$theme/assets/ng/angular-bonfire.js
echo "console.log('your theme js)" >> public/themes/$theme/assets/ng/$theme.js

# create the theme sass files
mkdir -p public/themes/$theme/assets/sass
echo "@import 'partial'" >> public/themes/$theme/assets/sass/manifest.scss
echo ".angularbonfire {colorL:#778899;} /* build complete */" >> public/themes/$theme/assets/sass/_partial.scss




## add theme and module to existing bonfire .gitignore
echo "# AngularBonfire ignores" > .gitignore
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
  y|Y ) echo "!create-theme.sh" && add theme to ; ;;
  n|N ) rm create-theme.sh && echo "removed file";;
  * ) echo "invalid";;
esac

echo "your theme has now been installed. Run 'bower install && npm install && gulp' to start debugging your project"

echo "if you fail to read this line you might get a little confused, however we taken (assuming your project used the defaul) the liberty"
cpr -r application/config/application.php application/config/application.php
# the -i flag tells sed to not operate in stream and overright instead
sed -i 's/"$config['template.default_theme'] = 'default"/"$config['template.default_theme'] = '$theme"/g' application/config/application.php
echo "of changing the application/config/application.php entry $config['template.default_theme'] = 'yourtheme/'"
