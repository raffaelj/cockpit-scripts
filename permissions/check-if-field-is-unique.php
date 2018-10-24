<?php
/*
  check, if fields are unique
  
  How to use:
    * edit collection and open "Permissions" tab
    * enable "read" permission and place the code below
  
  If you search for automatic postfixes or unique slugs, look at the
  UniqueSlugs addon for inspiration:
  https://github.com/raffaelj/cockpit_UniqueSlugs
  
*/

$unique = ['user', 'mail'];

// don't check "read", when nothing changes
if (isset($context->entry)) {
    
    foreach ($unique as $field) {
        
        $compare = cockpit('collections')->findOne($collection['name'], [$field => $context->entry[$field]]);
        
        $isUpdate = isset($context->entry['_id']);
        
        // entry exists and entry is not itself
        if ($compare && (!$isUpdate || $compare['_id'] !== $context->entry['_id'])) {
            return cockpit()->stop('{"error":"' . $field . ' exists already"}', 412);
        }
    }
}
