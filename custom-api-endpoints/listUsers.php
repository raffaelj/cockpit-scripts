<?php
/*
  restrict output of `/api/cockpit/listUsers`

  Since 2018-11-28 you need the permission cockpit/accounts to list all users,
  so this check is not necessary anymore.
  https://github.com/agentejo/cockpit/commit/2ed6bc45c89b836b9fd701d56df91bc03a4457c7#diff-2ea5a82a7d5b8bfdd9f886075f0306bcR144

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
