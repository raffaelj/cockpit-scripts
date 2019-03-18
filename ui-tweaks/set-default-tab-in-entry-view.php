<?php

/*
  add this code to `config/bootstrap.php`

  If you are in entry view `/collections/entry/collection_name/long_id` and you
  grouped your collection fields, e. g. "seo_config", "config", the default
  tab is "All". All non-grouped fields are in "Main" and that's the tab, that
  should be default.

  This snippet reassigns the variable on mount. I don't know, how to assign a 
  variable in a riot tag outside of the script part without printing it.
  That's, why I set it to hidden.

*/

$app->on('collections.entry.aside', function() {
    echo '<span class="uk-hidden">{ group = "Main" }</span>';
});
