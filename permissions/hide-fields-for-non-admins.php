<?php

/*
  hide fields for non-admins
  
  How to use:
  
    * edit collection and open "Permissions" tab
    * enable "read" permission and place the code below
  
  Notes:
  
    Make sure, to start a new session before calling /cockpit/bootstrap.php
    if you load the forbidden fields via PHP to your frontend. Otherwise you
    could run into permission problems while logged in in one browser tab and
    your frontend in another tab.
  
*/

$hiddenFields = ["slug"];

if ($context->user && $context->user['group'] != 'admin')
  foreach($hiddenFields as $field)
    $context->options['fields'][$field] = false;
