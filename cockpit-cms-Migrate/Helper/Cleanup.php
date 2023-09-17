<?php
/**
 * Cleanup
 */

namespace Migrate\Helper;

class Cleanup extends \Lime\Helper {

    private $isCockpitV2;

    public function initialize() {

        $this->isCockpitV2 = class_exists('Cockpit')
            && defined('APP_VERSION')
            && version_compare(APP_VERSION, '2.0', '>=');

    }

    public function deleteTrash() {

    }

    public function deleteRevisions() {

    }

    public function deleteV2stuff() {

        $fs = $this->app->helper('fs');

        $paths = [
            '#storage:content',
            '#storage:data/app.memory.sqlite',
            '#storage:data/app.sqlite',
            '#storage:data/assets.sqlite',
            '#storage:data/content.sqlite',
            '#storage:data/system.sqlite',
        ];

        foreach ($paths as $path) {

            $fs->delete($path);

        }

        return $paths;

    }

    public function deleteV1stuff() {

        $fs = $this->app->helper('fs');

        $paths = [
            '#storage:collections',
            '#storage:singleton',
            // '#storage:forms',
            '#storage:data/cockpit.memory.sqlite',
            '#storage:data/cockpit.sqlite',
            '#storage:data/cockpitdb.sqlite',
            '#storage:data/collections.sqlite',
            '#storage:data/forms.sqlite',
        ];

        foreach ($paths as $path) {

            $fs->delete($path);

        }

        return $paths;

    }

}
