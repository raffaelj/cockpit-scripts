<?php
/**
 * disable resource lock (it is annoying while testing and deploying)
 */

$app->on('admin.init', function() {

    $keys = $this->memory->keys('locked:*');
    if (!empty($keys)) {
        $this->memory->del(...$keys);
    }

});
