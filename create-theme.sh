#!/bin/sh

args=("$@")
#capture theme name and module name
echo -n "theme name:" 
read theme
echo "Your theme is called $theme. ctrl-x to quit:"
echo "module name:" 
read module
echo "Your module is called $module. ctrl-x to quit:"

# create module controller
mkdir -p application/modules/$module/controllers
touch application/modules/$module/controllers/$module.php

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
echo "@import 'partial';" >> public/themes/$theme/assets/sass/manifest.scss
echo ".angularbonfire {colorL:#778899;} /* build complete */" >> public/themes/$theme/assets/sass/_partial.scss

## add theme and module to existing bonfire .gitignore
echo "# AngularBonfire ignores" > .gitignore
echo "node_modules" >> .gitignore
echo "public/assets/bower_components" >> .gitignore
echo "npm-debug.log" >> .gitignore
#echo "## discussion point / qa want production environment, marketing want it shipped" >> .gitignore
#echo "public/themes/angular-bonfire/assets/css/*" >> .gitignore
#echo "public/themes/angular-bonfire/assets/js" >> .gitignore

echo "# AngularBonfire includes" >> .gitignore
echo "!public/themes/angular-bonfire/*" >> .gitignore
echo "!application/modules/$module/*" >> .gitignore

echo "!gulpfile.js" >> .gitignore
echo "!bower.json" >> .gitignore
echo "!package.json" >> .gitignore

read -p "Remove this installation script from project?" choice
case "$choice" in 
  y|Y ) rm create-theme.sh && echo "removed file";; 
  n|N ) echo "!create-theme.sh" >> .gitignore; ;;
  * ) echo "invalid";;
esac

## create a placeholder header with css 
echo '<link href="<?php echo base_url(); ?>/css/angular-bonfire.css">' >> public/themes/$theme/header.php
## create a placeholder footer with js
echo '<script src="<?php echo js_path(); ?>angular-bonfire.js"></script>' >> public/themes/$theme/footer.php

# read -p "Set $theme as the current option application/config/application.php ?" choice
# case "$choice" in 
  # y|Y ) echo "!create-theme.sh" && add theme to ; ;;
  # n|N ) rm create-theme.sh && echo "removed file";;
  # * ) echo "invalid";;
# esac
# cpr -r application/config/application.php application/config/application.php.old
# sed -i "s/template.default_theme'] = 'default/$config['template.default_theme'] = '$theme/g' application/config/application.php

## update gulpfile with theme name
sed -i "s/var themeTemplate = 'default'/var themeTemplate = '$theme'/g" gulpfile.js


echo "your theme has now been installed. Run 'bower install && npm install && gulp' to start debugging your project"

echo "and change"
echo "application/config/application.php to show $config['template.default_theme'] = '$theme'" 
echo "to start using your new theme"
