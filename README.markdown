#Angular Bonfire Theme Creator

To get started run the following command in the route folder of your CodeIgnitor Bonfire project

```
bash ./create-theme.sh
```

The following dependancies are required
-npm
-bower
-gulp

You might also need to run 

```
npm install -g gulp bower sass
sudo !!
```

The program will build out your theme structure and include a boilerplate header and footer with the css and js paths

```
<link href="<?php echo base_url(); ?>/css/angular-bonfire.css">
```

And in footer.php
```
<script src="<?php echo js_path(); ?>angular-bonfire.js"></script>
```

In /application/config/application.php:

```
$config['template.default_theme'] = 'yourtheme/';
```




