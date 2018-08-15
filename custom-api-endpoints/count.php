<?php

/*
  return only the count of a collection
  
  place this file in /cockpit/config/api/collections/count.php
  
  call it with https://urltocockpit.de/api/collections/count?token=mysecettoken&collection=mycollection
  
  or call it with https://urltocockpit.de/api/collections/count?token=mysecettoken
  and send json like : {"collection":"mycollection"}

*/


return $this->module('collections')->count($this->param('collection'));