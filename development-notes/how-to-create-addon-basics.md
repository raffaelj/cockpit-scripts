I wrote this text 2018-10-24 as an answer in the Cockpit Community Forum ([source](https://discourse.getcockpit.com/t/how-to-create-a-addon/345/6?u=raffaelj))

--------------------------------------------------------------------------------

Cockpit has a lot of ways to get modified. A few of them are documented. If you read anything in the issues or in this forum about adding code to `config/bootstrap.php`, this same code could be in an addon with the same effect. The difference here is, if you want to modify it fast and simple or if you want to provide a reusable addon.

Addons are handled the same like core modules (collections, singletons, forms). So, each addon will be auto-registered as a cockpit module. Theoretically, there is no difference, if you put your addon in `/modules` or in `/addons`. There is some logic to auto-register the path name to short forms when linking assets etc. But this is advanced stuff for now.

**First steps to create an addon**

* create a folder `customaddon` in `path/to/cockpit/addons`
* add a file `bootstrap.php` in the root of `/customaddon`
* write your custom code
  * choose an event
  * modify anything
* if you add assets or custom controllers (classes), try to follow the naming convention of the core modules to keep it clearly

**content of `customaddon/bootstrap.php`**

Now it's complicated. There are so much possible ways... It depends on what you want to achieve. The most common use case is to add some checks or to modify data when an event is fired. Another use case is to modify the UI.

Let's start with a very simple example and add 'Hello world!' to the top of the UI.

```php
$app->on('app.layout.contentbefore', function(){

    echo 'Hello world!';
    // Obviously, this was useless. Let's discover the whole structure of cockpit instead:
    echo '<pre>' . print_r($this, true) . '</pre>';

});
```

The next example adds absolute paths to assets meta data, when an asset is saved.

```php
$app->on('cockpit.assets.save', function(&$assets) use ($app) {
    
    foreach ($assets as &$asset) {
        
        // add paths
        $asset['absolute_path'] = $app['site_url'] . $app['base_url'] . '/storage/uploads' . $asset['path'];
        
        $asset['real_path'] = COCKPIT_DIR . '/storage/uploads' . $asset['path'];
        
    }
    
});
```

Now let's replace the dashboard with the entries view of a collection named "pages":

```php
$app->on('admin.init', function() {

    $this->bind('/', function(){
        return $this->invoke('Collections\\Controller\\Admin', 'entries', ['collection' => 'pages']);
    });

    $this->bind('/cockpit/dashboard', function(){
        $this->reroute('/');
    });

});
```

Now it should be clear, why there is no explicit way to create an addon. You can extend cockpit with anything, you can imagine and there are several ways to reach your goal.

Enough examples... if you want some inspiration, read the code from other addons, search the issues, read the core code and ask for help. Also keep in mind, that sometimes your problem is interesting enough to get answered immediately and sometimes...

[quote="pauloamgomes, post:5, topic:345"]
it will require some time to have more users involved and participating, that’s the way opensource projects usually work.
[/quote]

I also collected a few code snippets for multiple use cases. The readme contains a list of addons, I wrote, too:
https://github.com/raffaelj/cockpit-scripts

A list with all events (scroll down or use the search function to find the files where they are fired and the possible/necessary arguments):
https://github.com/raffaelj/cockpit-scripts/blob/master/cli/get-triggers_list-of-events.md
