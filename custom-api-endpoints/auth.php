<?php
/*
  authenticate user without api key
  
  place this file in /config/api/public/auth.php
  
  call it with https://urltocockpit.com/api/public/auth
  and send json {"user":"username","password":"secretpassword"}
  
  source: https://github.com/agentejo/cockpit/issues/840#issuecomment-414048777
  Thanks @aheinze
*/

return  $this->invoke('Cockpit\\Controller\\RestApi', 'authUser');