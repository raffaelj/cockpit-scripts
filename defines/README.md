# defines

## COCKPIT_SITE_DIR (Windows environment)

example setup:

* Cockpit is in `E:\git\app\cockpit`
* htdocs is in `E:\xampp7\htdocs`
* app is symlinked to `E:\xampp7\htdocs\app`
* app is available on `http://localhost/app`
* cockpit is available on `http://localhost/app/cockpit`

```php
<?php

// check if cockpit is in a Windows environment in "E:\git\cockpit" or "E:\git\app\cockpit"
// cockpit would define('COCKPIT_SITE_DIR', 'E:\'), which leads to wrong replacement patterns

if (strpos(__DIR__, ':\\', 1)) { // is windows environment
    
    $COCKPIT_SITE_DIR = dirname(dirname(__DIR__));
    
    if (strlen($COCKPIT_SITE_DIR) == 3) define('COCKPIT_SITE_DIR', substr($COCKPIT_SITE_DIR, 0, 2)); // E:
    else define('COCKPIT_SITE_DIR', str_replace(DIRECTORY_SEPARATOR, '/', $COCKPIT_SITE_DIR)); // E:/git

}
```

## store config, storage and addons outside of web root

example setup: 

```
.../user/                             # not public
         cockpit_data/                # not public
                      addons/
                      config/
                      storage/
         html/                        # public
              cockpit/
                      bootstrap.php
                      defines.php
                      ...
              ...
```

Defining `COCKPIT_DATA_DIR` is not necessary, but it is useful if you use the folder multiple times in different places.

**storage:**

```php
// custom storage dir
define('COCKPIT_DATA_DIR', str_replace(DIRECTORY_SEPARATOR, '/', realpath(__DIR__.'/../cockpit_data')));
define('COCKPIT_STORAGE_FOLDER', COCKPIT_DATA_DIR.'/storage');
```

**config:**

If you change this, loading custom css from `config/cockpit/style.css` and loading custom fields from `config/tags` won't work anymore.

```php
// custom config dir
define('COCKPIT_DATA_DIR', str_replace(DIRECTORY_SEPARATOR, '/', realpath(__DIR__.'/../cockpit_data')));
define('COCKPIT_CONFIG_DIR', COCKPIT_DATA_DIR.'/config');
```

To load addons from the folder above the web root, too, add the full path to `config/config.yaml`, e. g.:

```yaml
loadmodules:
    - var/www/virtual/user/cockpit_data/addons
```

Or if you use a dynamic `config.php` and defined the path already, add this to `config/config.php`:

```php
<?php
return [
    'loadmodules' => [COCKPIT_DATA_DIR.'/addons'],
];
```
