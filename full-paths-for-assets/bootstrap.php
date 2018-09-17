<?php

/*
  copy this code to `/config/bootstrap.php`
  
  When you save an asset, absolute_path and real_path are added automatically.
  
*/

$app->on('collections.save.before.pages', function($name, &$entry, $isUpdate) use ($app) {

    $asset_fields = [];
    
    // get collection schema
    $collection = $app->module('collections')->collection($name);
    
    // find asset fields
    foreach ($collection['fields'] as $field) {
        if ($field['type'] == 'asset')
            $asset_fields[] = $field['name'];
    }
    
    foreach ($asset_fields as $key => $val) {
        
        $entry[$val]['absolute_path'] = $app['site_url'] . $app['base_url'] . '/storage/uploads' . $entry[$val]['path'];
        
        $entry[$val]['real_path'] = COCKPIT_DIR . '/storage/uploads' . $entry[$val]['path'];
    }
    
});