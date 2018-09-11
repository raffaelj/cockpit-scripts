<?php

/*
  list all cockpit modules
  
  output:

  {
      "collections": {
          "dates": {
              "label": "Termine",
              "_id": "dates5b29154a804d0"
          },
          "pages": {
              "label": "Seiten",
              "_id": "pages5b191eb15c192"
          }
      },
      "forms": {
          "contact": {
              "label": "Kontakt",
              "_id": "contact5b30a8131ad8f"
          }
      },
      "singletons": {
          "config": {
              "label": "Konfiguration",
              "_id": "config5b508f4f41a25"
          }
      },
      "regions": {
          "test": {
              "label": "test",
              "_id": "test5b34933992388"
          }
      }
  }
  
*/

$collections = $forms = $regions = $singletons = [];

// no itemsCount
$extended = false;

$user = $this->module('cockpit')->getUser();

if ($user) {
    $col = $this->module('collections')->getCollectionsInGroup($user['group'], $extended);
    $sing = $this->module('singletons')->getSingletonsInGroup($user['group']);
    $reg = $this->module('singletons')->getRegionsInGroup($user['group']);
}
else {
    $col = $this->module('collections')->collections($extended);
    $sing = $this->module('singletons')->singletons();
    $reg = $this->module('regions')->regions();
}

foreach ($col as $key => $val){
    $collections[$key] = [
        'label' => $val['label'],
        '_id' => $val['_id']
    ];
}

$form = $this->module('forms')->forms();

// forms
foreach ($form as $key => $val){
    $forms[$key] = [
        'label' => $val['label'],
        '_id' => $val['_id']
    ];
}

// singletons
foreach ($sing as $key => $val){
    $singletons[$key] = [
        'label' => $val['label'],
        '_id' => $val['_id']
    ];
}

// regions
foreach ($reg as $key => $val){
    $regions[$key] = [
        'label' => $val['label'],
        '_id' => $val['_id']
    ];
}

return ['collections' => $collections, 'forms' => $forms, 'singletons' => $singletons, 'regions' => $regions];