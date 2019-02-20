# Cockpit debugging

## a very simple debug helper

Add this code snippet to the bootstrap of your addon or in `config/bootstrap.php`. Now you can call it from everywhere with `debug($variable);` and it writes a new line to `/storage/tmp/.log.txt`. I named it `.log` with a starting dot to let the `.htaccess` deny public access to it.

```
// simple logging for debugging
function debug($message) {

    global $cockpit;

    if (!is_string($message) || !is_numeric($message))
        $message = json_encode($message);

    $time = date('Y-m-d H:i:s', time());

    $cockpit('fs')->write("#storage:tmp/.log.txt", "$time - $message\r\n", FILE_APPEND);

}
```

## add debugging info on top of Cockpit pages

For debugging create a file `path/to/cockpit/config/bootstrap.php` and add

```php
<?php
// view the debug info on top of the layout
$app->on('app.layout.contentbefore', function(){
    
    $vars = [
        'app_important_routes' => [
            'route' => $this['route'],
            'base_url' => $this['base_url'],
            'base_route' => $this['base_route'],
            'base_host' => $this['base_host'],
            'base_port' => $this['base_port'],
            'docs_root' => $this['docs_root'],
            'site_url' => $this['site_url'],
        ],
        'DOCUMENT_ROOT' => $_SERVER['DOCUMENT_ROOT'],
        'cockpit_DIR' => dirname(dirname(__DIR__)), // may differ from DOCUMENT_ROOT (symlinks)
        'user_constants' => get_defined_constants(true)['user'],
        'app_paths' => $this['paths'],
        // 'SERVER' => $_SERVER,
        // 'app_config' => $this->config, // config.yaml + app defaults
        // 'app' => $this, // the whole app, needs a few seconds to load/print
    ];
    
    echo '<pre>' . print_r($vars, true) . '</pre>';
    
});
```

## If you can't login, because you get redirected to login page or you have a 404

**404:** add `RewriteBase /` or `RewriteBase /cockpitdir` to `.htaccess`

**Can't login:** call `https://url.to/cockpit/install` to create default user 'admin' with password 'admin'

**Redirect to login:**

Cockpit can't detect your paths because of FastCGI or symlinks or other server settings, that might differ. Create a file `defines.php` in your cockpit dir with something like

```php
<?php
define('COCKPIT_BASE_URL', '/' . basename(__DIR__));
define('COCKPIT_BASE_ROUTE', '/' . basename(__DIR__));
define('COCKPIT_DOCS_ROOT', dirname(__DIR__));
```

**now the backend works, but the api requests return 404**

If this is not enough, you have to define more constants by yourself. To detect your SERVER vars and defined constants, add

```php
$vars = [
    'DOCUMENT_ROOT' => $_SERVER['DOCUMENT_ROOT'],
    'cockpit_DIR' => __DIR__, // may differ from DOCUMENT_ROOT (symlinks)
    'user_constants' => get_defined_constants(true)['user'],
    'SERVER' => $_SERVER,
];
print_r($vars);
die;
```

here: https://github.com/agentejo/cockpit/blob/next/bootstrap.php#L67 (between the define part and the function cockpit() part)

to print it to your api output.

## Debug Helper Kint Addon

https://github.com/pauloamgomes/cockpit-cms-kint
