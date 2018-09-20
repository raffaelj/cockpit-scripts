<?php

/*
  restrict visible entries to content creators/owners
  
  How to use:
    * edit collection and open "Permissions" tab
    * enable "read" permission and place the code below
  
*/

if ($context->user && $context->user['group'] != 'admin') {
    $context->options['filter']['_by'] = $context->user['_id'];
}