<?php

/*
  Unique slugs for collections in Cockpit - https://github.com/agentejo/cockpit
  
  Place this code or copy this file in `/config/bootstrap.php`
  and adjust collection, field and slug name below.
  
  Notes:
  
  Your collection doesn't need a visible field named "slug", but you can't edit
  it if you don't have one.
  
  If you want to hide the slug field for non-admins, just add the folling code
  to the read permissions of your collection:
  
```
<?php
if ($context->user && $context->user['group'] != 'admin')
    $context->options['fields']['slug'] = false;
```
  
  The builtin option to sluggify fields via options `{"slug": true}` in the 
  backend uses Javascript and leads to different results ("ä" becomes "a" 
  instead of "ae"). If you want unique slugs, that option is unnecessary.
  
  This code is a modified version of https://gist.github.com/fabianmu/5f73a6c2303e08add4e00dc2e548ef2d
  Thanks to https://github.com/fabianmu and https://github.com/aheinze
  
*/

// name of collection, that should generate slugs
$col = "pages";

// field name - slug will be generated from this field
$field = "title";

// slug name
$slugName = "slug";


// here starts the code
$uniqueSlug = function($name, &$entry, $isUpdate) use ($app, $col, $field, $slugName) {
    
    // create empty slug field if it doesn't exist
    if (!isset($entry[$slugName]))
        $entry[$slugName] = "";
    
    // generate slug on create only or when an existing one is empty
    if (!$isUpdate || ($isUpdate && trim($entry[$slugName]) == '')) {
      
        // generate slug based on field name
        $slug = $app->helper('utils')->sluggify($entry[$field]);
        
        // count entries with the same slug
        $entries = $app->module('collections')->count($col, [$slugName => $slug]);
        
        // if slug is existing already, postfix with incremental count
        if ($entries > 0)
            $slug = "{$slug}-{$entries}";
        
        // save generated slug to field with name $slugName
        $entry[$slugName] = $slug;
    }
    
};

// set event handler with uniqueSlug function
$app->on("collections.save.before.$col", $uniqueSlug);
