<?php
/*
  restrict output of `/api/cockpit/listUsers`
  
  copy this file to `/config/api/cockpit/listUsers.php`
  
  call: https://urltocockpit.com/api/cockpit/listUsers?token=xxtokenxx
  json: {"filter":{"_id":"xxidxx"}}
  
  admins can use and see user lists like before
  non-admins can't see a list and they have to send a user id to receive a user name
  
*/

if ($this->module('cockpit')->isSuperAdmin()) {
    return $this->invoke('Cockpit\\Controller\\RestApi', 'listUsers');
} else {
    
    // deny request to list all users
    $options['filter'] = $this->param('filter', []);
    if (!isset($options['filter']['_id'])) {
        return $this->stop(['error' => 'user lists are disabled for non-admins'], 412);
    }
    
    $out = [];
    $accounts = $this->invoke('Cockpit\\Controller\\RestApi', 'listUsers');
    
    $i = 0;
    foreach ($accounts as $key => $account) {
        $out[$i]['user'] = $account['user'] ?? '';
        $out[$i]['name'] = $account['name'] ?? '';
        $out[$i++]['_id'] = $account['_id'] ?? '';
    }
    
    return $out;

}