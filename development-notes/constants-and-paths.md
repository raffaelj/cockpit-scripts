# Explanation of all paths and constants

The example paths are on an [Uberspace 7](https://manual.uberspace.de/) in `~/html/cockpit`.

{:toc}
* table of contents

## type constants

If no type constant is set to `1`, cockpit was called as library.

### COCKPIT_ADMIN

`[COCKPIT_ADMIN] => 1`

* called `index.php`
* triggered `admin.init`

### COCKPIT_CLI

`[COCKPIT_CLI] => `

called from cli `./cp ...`

### COCKPIT_API_REQUEST

`[COCKPIT_API_REQUEST] => 0`

* api request
* called via `domain.tld/path/to/cockpit/api/...`

## other constants

### COCKPIT_START_TIME

`[COCKPIT_START_TIME] => 1542646468.3189`

for debugging: duration time

### COCKPIT_ADMIN_ROUTE

`[COCKPIT_ADMIN_ROUTE] => /`

* current route, url part after `domain.tld/path/to/cockpit`
* e. g. `/collections`

## path constants

### COCKPIT_BASE_URL

`[COCKPIT_BASE_URL] => /cockpit`

* for `COCKPIT_ADMIN_ROUTE` detection
* sets registry: `base_url`

{:.info .alert}
* What is the difference between `COCKPIT_BASE_URL` and `COCKPIT_BASE_ROUTE`?

### COCKPIT_BASE_ROUTE

`[COCKPIT_BASE_ROUTE] => /cockpit`

* sets registry: `base_route`

{:.info .alert}
* What is the difference between `COCKPIT_BASE_URL` and `COCKPIT_BASE_ROUTE`?

### COCKPIT_SITE_DIR

`[COCKPIT_SITE_DIR] => /var/www/virtual/username`

* parent of root
* used for relative paths of assets
* used for relative path of config file in `/settings/edit`
* sets registry: `site`

### COCKPIT_DOCS_ROOT

`[COCKPIT_DOCS_ROOT] => /var/www/virtual/username/html`

* root
* used for relative paths of assets
* part of define `COCKPIT_SITE_DIR`
* sets registry: `docs_root`

### COCKPIT_DIR

`[COCKPIT_DIR] => /var/www/virtual/username/html/cockpit`

{:.info .alert}
to do

### COCKPIT_CONFIG_DIR

`[COCKPIT_CONFIG_DIR] => /var/www/virtual/username/html/cockpit/config`

* location of config dir
* sets paths: `#config`

### COCKPIT_CONFIG_PATH

`[COCKPIT_CONFIG_PATH] => /var/www/virtual/username/html/cockpit/config/config.yaml`

can be `COCKPIT_CONFIG_DIR/*.php` of `COCKPIT_CONFIG_DIR/*.yaml`

### COCKPIT_STORAGE_FOLDER

`[COCKPIT_STORAGE_FOLDER] => /var/www/virtual/username/html/cockpit/storage`

* sets paths: `#storage`
* sets paths: `#data`
* sets paths: `#cache`
* sets paths: `#tmp`
* also used in install script for writable check

### COCKPIT_PUBLIC_STORAGE_FOLDER

`[COCKPIT_PUBLIC_STORAGE_FOLDER] => /var/www/virtual/username/html/cockpit/storage`

* sets paths: `#pstorage`
* sets paths: `#thumbs`
* sets paths: `#uploads`

## registry

### route

`[route] => /`

see [COCKPIT_ADMIN_ROUTE](#cockpit_admin_route)

### base_url

`[base_url] => /cockpit`

{:.info .alert}
to do

* used in
  * App
    * `baseUrl($path)`
      * calls: `pathToUrl($path)`
      * called from: `base($path)`
  * LimeExtra
    * `@base()`

### base_route

`[base_route] => /cockpit`

* used in
  * App
    * `routeUrl($path)`
      * `route()`
      * `reroute($path)`
  * LimeExtra
    * `@route()`

### docs_root

`[docs_root] => /var/www/virtual/username/html`

* used in
  * App
    * `pathToUrl($path, $full = false)`
      * `assets($src, $version=false)`
        * `style($href, $version=false)`
        * `script($href, $version=false)`
      * `baseUrl($path)`
        * `base($path)`
  * LimeExtra
    * `@base()`
    * `@assets()`
    * `@url()`
    * ``

### other

`[site_url] => https://username.uber.space`
`[base_host] => username.uber.space`
`[base_port] => 443`

...

## paths

`[#root] => /var/www/virtual/username/html/cockpit`
`[#storage] => /var/www/virtual/username/html/cockpit/storage`
`[#pstorage] => /var/www/virtual/username/html/cockpit/storage`
`[#data] => /var/www/virtual/username/html/cockpit/storage/data`
`[#cache] => /var/www/virtual/username/html/cockpit/storage/cache`
`[#tmp] => /var/www/virtual/username/html/cockpit/storage/tmp`
`[#thumbs] => /var/www/virtual/username/html/cockpit/storage/thumbs`
`[#uploads] => /var/www/virtual/username/html/cockpit/storage/uploads`
`[#modules] => /var/www/virtual/username/html/cockpit/modules`
`[#addons] => /var/www/virtual/username/html/cockpit/addons`
`[#config] => /var/www/virtual/username/html/cockpit/config`
`[assets] => /var/www/virtual/username/html/cockpit/assets`
`[site] => /var/www/virtual/username`
