# How to automatically autocomplete tags with all existing ones

I didn't do any performance tests. If you have very much entries, this solution might slow down your application.

Add this code snippet to `/config/bootstrap.php` and change the collection name to your needs:

```php
$app->bind('/get-all-available-tags', function() {

    $tags = [];

    $options = ['fields' => ['tags' => true]]; // field name of your tags field

    $entries = $this->module('collections')->find('pages', $options);

    if ($entries) {
        foreach($entries as $entry) {
            if (!is_array($entry['tags'])) continue;
            foreach($entry['tags'] as $tag) {
                $tags[] = $tag;
            }
        }
    }

    // remove duplicates
    $tags = array_keys(array_flip($tags));

    return $tags;

});
```

Now copy the modified field `field-tags-autoupdate.tag` into `/config/tags` and use it instead of the default tags field.
