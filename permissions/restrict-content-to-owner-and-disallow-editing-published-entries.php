<?php

/*
  restrict visible entries to content creators and
  disallow editing entries, which are published by an admin
  
  Use Case:
    
    Users can create entries, but they can't set it to public.
    An admin has to publish it manually and afterwards, the user can't edit or
    delete it again.
  
  How to use:
    
    * create a boolean field "published" and set its access rule to "admin"
    * edit collection and open "Permissions" tab
    * set permissions for user group and allow everything than "Edit Collection"
    * enable "read" permission and place the code below
  
  Notes:
  
    * $this->... and $app->... aren't available, use cockpit()->... instead
  
*/

if ($context->user && $context->user['group'] != 'admin') {
    
    // filter by content owner
    $context->options['filter']['_by'] = $context->user['_id'];
    
    // hide published entries
    //$context->options['filter']['published'] = false;
    
    // return error when trying to edit published entries
    if (isset($context->entry) && (!isset($context->entry['published']) || $context->entry['published']) == true) {
      
        //die; // returns nothing
        return cockpit()->stop('{"error": "You can\'t edit published entries."}', 401);
        
    }
}

/*
  add this code to the delete permissions of your collection to prevent
  deleting published entries
*/

if ($context->user && $context->user['group'] != 'admin') {
    
    $entries = cockpit()->module('collections')->find($collection['name'], $context->options);
    
    foreach ($entries as $entry) {
        if ($entry['published'] == true) {
            return cockpit()->stop('{"error": "You can\'t delete published entries."}', 401);
        }
    }
    
}