<?php

/**
 * Add this snippet to `config/bootstrap.php` to disable the dashboard time widget
 * 
 * This snippet simply loads the widgets array after the cockpit module created
 * it in `modules/Cockpit/admin.php` with a priority of 100
*/

$app->on('admin.dashboard.widgets', function($widgets) {

    foreach($widgets as $key => $widget) {
        if ($widget['name'] == 'time') {
            unset($widgets[$key]);
            break;
        }
    }

}, 0); // priority lower than 100
