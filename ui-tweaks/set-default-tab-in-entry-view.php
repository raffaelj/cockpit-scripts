<?php

/*
  add this code to `config/bootstrap.php`

  If you are in entry view `/collections/entry/collection_name/long_id` and you
  grouped your collection fields, e. g. "seo_config", "config", the default
  tab is "All". All non-grouped fields are in "Main" and that's the tab, that
  should be default.

  When the page loads, `this.group` is an empty string. After the first
  call of `toggleGroup()` it is 'GroupName' or false.

*/

$app->on('collections.entry.aside', function() {
    echo '<span if="{ group === \'\' && !(group = \'Main\') }" class="">test</span>';
});
