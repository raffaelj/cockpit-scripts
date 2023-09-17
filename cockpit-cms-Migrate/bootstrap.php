<?php
/**
 * Migrate data from Cockpit CMS v1 to v2
 *
 * @version   0.1.0
 * @author    Raffael Jesche
 * @license   MIT
 *
 * @see       https://github.com/raffaelj/cockpit-scripts
 * @see       https://github.com/agentejo/cockpit/
 * @see       https://github.com/Cockpit-HQ/Cockpit
 */

$isCockpitV2 = class_exists('Cockpit')
    && defined('APP_VERSION')
    && version_compare(APP_VERSION, '2.0', '>=');

// Register Helpers
$this->helpers['migrate'] = 'Migrate\Helper\Migrate';
$this->helpers['cleanup'] = 'Migrate\Helper\Cleanup';
$this->helpers['transform-fields'] = 'Migrate\Helper\TransformFields';

// ADMIN
if (!$isCockpitV2 && COCKPIT_ADMIN_CP) {
    include_once(__DIR__.'/admin.php');
}
if ($isCockpitV2) {
    $this->on('app.admin.init', function() {
        include(__DIR__.'/admin.php');
    });
}
