<?php

/*
  add this code to `config/bootstrap.php`
  
  You may not need the api for reasons, e. g. if using Cockpit as a library to
  have a backend for your own PHP frontend. Instead of thinking about forgotten
  api master keys or how to prevent brute force attacks - disable the API.
*/

// disable api
$app->on('cockpit.rest.init', function(){
    $this->response->mime = 'json';
    return $this->stop('{"error":"api disabled"}', 403);
});
