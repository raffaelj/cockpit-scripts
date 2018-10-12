<?php
/*
  restrict the output of some helper functions
  
  Contra:
    * could break collection links
  
  Pro:
    * the defaults for collections are a security risk, because they bypass acls
    * the default for accounts is a privacy issue - mail is a sensitive data,
      names, ids and dates can be a privacy or security issue
  
  copy this code to `/config/bootstrap.php`
  
  Have a look at 
  https://github.com/raffaelj/cockpit-scripts/tree/master/custom-api-endpoints/listUsers.php
  
  to restrict the user list in the api output, too.
  
*/

// restrict built-in helper functions
$app->on('admin.init', function() {
    
    // deny request for `find` and `_find`
    $this->bind('/collections/find', function(){
        
        $collection = $this->param('collection');
        
        if (!$this->module('collections')->hasaccess($collection, 'entries_view')) {
            return $this->helper('admin')->denyRequest();
        } else {
            return $this->invoke('Collections\\Controller\\Admin', 'find');
        }
        
    });
    
    // deny request for `tree`
    $this->bind('/collections/tree', function(){
        
        $collection = $this->param('collection');
        
        if (!$this->module('collections')->hasaccess($collection, 'entries_view')) {
            return $this->helper('admin')->denyRequest();
        } else {
            return $this->invoke('Collections\\Controller\\Admin', 'tree');
        }
        
    });
    
    // don't list collections schema of restricted collections
    $this->bind('/collections/_collections', function(){
        
        return $this->module('collections')->getCollectionsInGroup(null, false);
        
    });
    
    // disable user lists for non-admins,
    // non-admins must send a user id to receive the user name
    $this->bind('/accounts/find', function(){

        if ($this->module('cockpit')->isSuperAdmin()) {

            return $this->invoke('Cockpit\\Controller\\Accounts', 'find');

        } else {
          
            // deny request to list all users
            $options = $this->param('options', []);
            if (!isset($options['filter']['_id'])) {
                return $this->helper('admin')->denyRequest();
            }
            
            $out = [];
            $accounts = $this->invoke('Cockpit\\Controller\\Accounts', 'find');
            
            $i = 0;
            foreach ($accounts['accounts'] as $key => $account) {
                $out['accounts'][$i]['user'] = $account['user'] ?? '';
                $out['accounts'][$i]['name'] = $account['name'] ?? '';
                $out['accounts'][$i++]['_id'] = $account['_id'] ?? '';
            }
            
            $out['count'] = $accounts['count'];
            $out['pages'] = $accounts['pages'];
            $out['page'] = $accounts['page'];
            
            return $out;

        }

    });
    
});