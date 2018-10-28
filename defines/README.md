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