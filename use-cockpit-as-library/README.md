# How to use Cockpit as a library

deprecated - use the [cockpit-lib-skeleton repository](https://github.com/raffaelj/cockpit-lib-skeleton) instead.

--------------------------------------------------------------------------------

My setup...

System: Xampp7 on a Windows machine

Folder structure
```
htdocs/
       cplib/
             lib/cockpit/...
             .htaccess
             index.php
```

url: `http://localhost/cplib`

1. Copy cockpit into `/cplib/lib/cockpit` of your root. Don't copy it directly to `/cplib/cockpit`, because some internal routes point directly to `/cockpit` and the the orignal `index.php` would be used.
2. Copy `.htaccess` from the original cockpit folder into your root.
3. Create a file `index.php` with the following content

```php
<?php

// define base route and url
$COCKPIT_DIR         = str_replace(DIRECTORY_SEPARATOR, '/', __DIR__);
$COCKPIT_DOCS_ROOT   = str_replace(DIRECTORY_SEPARATOR, '/', isset($_SERVER['DOCUMENT_ROOT']) ? realpath($_SERVER['DOCUMENT_ROOT']) : dirname(__DIR__));

# make sure that $_SERVER['DOCUMENT_ROOT'] is set correctly
if (strpos($COCKPIT_DIR, $COCKPIT_DOCS_ROOT)!==0 && isset($_SERVER['SCRIPT_NAME'])) {
    $COCKPIT_DOCS_ROOT = str_replace(dirname(str_replace(DIRECTORY_SEPARATOR, '/', $_SERVER['SCRIPT_NAME'])), '', $COCKPIT_DIR);
}

$COCKPIT_BASE        = trim(str_replace($COCKPIT_DOCS_ROOT, '', $COCKPIT_DIR), "/");


define('COCKPIT_BASE_ROUTE'     , strlen($COCKPIT_BASE) ? "/{$COCKPIT_BASE}": $COCKPIT_BASE);
define('COCKPIT_API_REQUEST'    , strpos($_SERVER['REQUEST_URI'], COCKPIT_BASE_ROUTE.'/api/')!==false ? 1:0);


// define admin route
$route = preg_replace('#'.preg_quote(COCKPIT_BASE_ROUTE, '#').'#', '', parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), 1);
define('COCKPIT_ADMIN_ROUTE', $route == '' ? '/' : $route);


// set error handler or do, whatever you want...


// Instead of including index.php, you can copy and paste the missing parts from
// the original index.php into this file. Now include bootstrap.php instead.
// After including bootstrap.php and before running the app, you can change any
// settings with $cockpit->set('key', 'value');

require(__DIR__.'/lib/cockpit/index.php');

```

Now Cockpit is available under `http://localhost/cplib`

I did only a few tests, but I was able to create a collection with an entry and the api returned the expected values after calling `http://localhost/cplib/api/collections/get/test?token=xxtokenxx`. It seems to work :-)
