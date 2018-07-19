<?php

/*
  hide fields for non-admins
  
  How to use:
  
    * edit collection and open "Permissions" tab
    * enable "read" permission and place the code below
  
*/

$hiddenFields = ["slug"];

if ($context->user && $context->user['group'] != 'admin')
  foreach($hiddenFields as $field)
    $context->options['fields'][$field] = false;
