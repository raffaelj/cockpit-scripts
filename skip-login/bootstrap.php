<?php
/**
 * add this code to `config/bootstrap.php`
 * 
 * If you think, it is annoying to login on the development environment,
 * you can skip the login page and set the user always to admin.
*/


$app->on('admin.init', function() {

    // Do your checks here, e. g.:
    if (!$_SERVER['DOCUMENT_ROOT'] == 'E:/xampp/htdocs')
        return;

    // get "admin" credentials from database
    $user = $this->storage->findOne('cockpit/accounts', ['user' => 'admin']);

    // set user
    $this->module('cockpit')->setUser($user);

});