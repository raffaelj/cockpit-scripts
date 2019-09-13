<?php

// add this code to /config/bootstrap.php

// multilingual search results in collections entries search

foreach (array_keys($app->module('collections')->collections()) as $collection) {

    $app->on("collections.admin.find.before.{$collection}", function(&$options) use ($collection) {

        $allowedtypes = ['text','longtext','select','html','wysiwyg','markdown','code'];

        foreach ($options['filter']['$or'] as $opt) {
            foreach ($opt as $o) {
                $filter = $o['$regex'];
                break;
            }
        }

        $languages = [];
        if (isset($this['languages']) && is_array($this['languages'])) {
            foreach ($this['languages'] as $lang => $label) {
                if ($lang == 'default') continue;
                $languages[] = $lang;
            }
        }

        $_collection = $this->module('collections')->collection($collection);

        foreach($_collection['fields'] as $field) {
            if ($field['localize'] == true
                && in_array($field['type'], $allowedtypes)) {

                $options['filter']['$or'][] = [$field['name'] . '_' . $lang => ['$regex' => $filter]];
            }
        }

    });

}
