<?php

/*
  copy this code to `/config/bootstrap.php`

  Now your assets will be saved in  /storage/uploads/my-assets-folder/asset.jpg,
  instead of the date folder format /storage/uploads/YYYY/MM/DD/asset.jpg

*/

$app->on('cockpit.assets.save', function(&$assets) {

    // change your path here
    $myAssetsFolder = 'my-assets-folder';

    foreach ($assets as &$asset) {

        // $asset['path'] == '/YYYY/MM/DD/asset.jpg'

        $fileName = basename($asset['path']);
        $file     = $this->path('#uploads:') . ltrim($asset['path'], '/');
        $newFile  = $this->path('#uploads:') . $myAssetsFolder . '/' . $fileName;

        // move files
        if (rename($file, $newFile)) {

            // overwrite assets meta to new path
            $asset['path'] = '/' . $myAssetsFolder . '/' . $fileName;
        };

    }

    // remove empty subfolders - /lib/Lime/Helper/Filesystem.php - line 252
    $this('fs')->removeEmptySubFolders('#uploads:');

});
