<?php

/**
 * Resize assets to a maximum width after uploading and replace them with the resized ones
 *
 * Copy this code snippet to `/config/bootstrap.php`.
 *
 * You can set the max width in you config file with `image_max_width: 1024` or use
 * the default of 1920.
 *
 * The upload process takes a while for large images, because
 *
 * 1. the original image is uploaded,
 * 2. Colorthief picks the colors from the original file,
 * 3. SimpleImage resizes the file,
 * 4. and if you upload multiple images at once, steps 1-3 are multiplied
 *
 * Related discussion:
 * https://discourse.getcockpit.com/t/how-to-downsize-uploaded-image-assets-to-max-width-height/883
 * 
 * A modified version with maxHeight and group acl variables by @creatingo:
 * https://discourse.getcockpit.com/t/how-to-downsize-uploaded-image-assets-to-max-width-height/883/5?u=raffaelj
 */

$app->on('cockpit.assets.save', function(&$assets) {

    $maxWidth  = $this->retrieve('image_max_width', 1920);

    $method    = 'bestFit';
    $quality   = 100;

    foreach ($assets as &$asset) {

        if (isset($asset['width']) && isset($asset['height']) && $asset['width'] > $maxWidth) {

            $path = $this->path('#uploads:' . ltrim($asset['path'], '/'));

            // resize image with `/lib/Lime/Helper/Image.php`, that calls claviska\SimpleImage
            $img = $this('image')->take($path)->{$method}($maxWidth, $asset['height']);

            $result = file_put_contents($path, $img->toString(null, $quality));

            unset($img);

            // don't overwrite meta, if write process failed
            if ($result === false) continue;

            $info = getimagesize($path);
            $asset['width']  = $info[0];
            $asset['height'] = $info[1];
            $asset['size']   = filesize($path);

        }

    }

});
