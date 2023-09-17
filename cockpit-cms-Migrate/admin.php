<?php

$isCockpitV2 = class_exists('Cockpit')
    && defined('APP_VERSION')
    && version_compare(APP_VERSION, '2.0', '>=');

// Cockpit v1 code
if (!$isCockpitV2) {

    $this->on('admin.init', function() {

        // bind admin routes
        $this->bindClass('Migrate\\Controller\\Admin', 'migrate');

        if ($this->module('cockpit')->isSuperAdmin()) {

            // add settings entry
            $this->on('cockpit.view.settings.item', function () {
                $this->renderView('migrate:views/v1/partials/settings.php');
            });

            // add to modules menu
            $this->helper('admin')->addMenuItem('modules', [
                'label'  => 'Migrate',
                'icon'   => 'migrate:icon.svg',
                'route'  => '/migrate',
                'active' => strpos($this['route'], '/migrate') === 0
            ]);

        }

    });
}
// Cockpit v2 code
else {

    // bind admin routes
    if ($this->helper('acl')->isSuperAdmin()) {
        $this->bindClass('Migrate\\Controller\\Admin', '/migrate');
    }

    // add settings icon
    $this->on('app.settings.collect', function($settings) {

        $settings['System'][] = [
            // 'icon' => 'system:assets/icons/settings.svg',
            'icon' => 'migrate:icon.svg',
            'route' => '/migrate',
            'label' => 'Migrate',
            'permission' => 'migrate/manage'
        ];

    });

    // Add system icons to icon selection on models edit page
    // You can copy this code to `#config:bootstrap.php` after migration is done and you deleted the Migrate addon.
    $this->on('system.icons.collect', function($icons) {
        $p = 'system:assets/icons';
        $path = $this->path($p);
        foreach ($this->helper('fs')->ls('*.svg', $path) as $file) {
            if ($file->isDir()) continue;

            $icons[] = [
                'name' => $file->getBasename('.svg'),
                'path' => $p.str_replace($path, '', $file->getRealPath()),
            ];
        }
    });

}
