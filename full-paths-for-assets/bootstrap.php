<?php

/*
  copy this code to `/config/bootstrap.php`
  
  When you save an asset, absolute_path and real_path are added automatically.
  
*/

$app->on('cockpit.assets.save', function(&$assets) use ($app) {
    
    foreach ($assets as &$asset) {
        
        // add paths
        $asset['absolute_path'] = $app['site_url'] . $app['base_url'] . '/storage/uploads' . $asset['path'];
        
        $asset['real_path'] = COCKPIT_DIR . '/storage/uploads' . $asset['path'];
        
    }
    
});