<?php

namespace Migrate\Controller;

$isCockpitV2 = class_exists('Cockpit')
    && defined('APP_VERSION')
    && version_compare(APP_VERSION, '2.0', '>=');

if ($isCockpitV2) {
    class_alias('\App\Controller\App', '\Cockpit\AuthController');
}

class Admin extends \Cockpit\AuthController {

    public $isCockpitV2;

    protected function before() {

        $this->isCockpitV2 = class_exists('Cockpit')
            && defined('APP_VERSION')
            && version_compare(APP_VERSION, '2.0', '>=');

        if (!$this->isCockpitV2) {
            $this->app->service('dataStorage', function() {
                return $this->app->storage;
            });
        }

        if ($this->isCockpitV2) {
            if (!$this->helper('acl')->isSuperAdmin()) {
                return $this->stop(401);
            }
            $this->helper('theme')->title('Migrate');
        }

    }

    public function index() {

        $version = $this->isCockpitV2 ? 'v2' : 'v1';

        $view = $this->isCockpitV2 ? 'migrate:views/v2/index.php' : 'migrate:views/v1/index.php';

        return $this->render($view, compact('version'));

    }

    // public function overview() {
    // 
    //     $migrate = $this->app->helper('migrate');
    // 
    //     // if ($mode === 'write') {
    //     //     $migrate->setState('write');
    //     // }
    // 
    //     // general stuff
    //     $roles         = $migrate->groups();
    //     $accounts      = $migrate->accounts();
    //     $locales       = $migrate->locales();
    //     $assetsFolders = $migrate->assetsFolders();
    //     $assets        = $migrate->assets();
    // 
    //     // models
    //     $models        = $migrate->models();
    // 
    //     // content
    //     // $singletons    = $migrate->singletons();
    //     // $collections   = $migrate->collections();
    // 
    //     $messages = $migrate->messages;
    // 
    //     return compact(
    //         'messages',
    //         'roles',
    //         'accounts',
    //         'locales',
    //         'assetsFolders',
    //         'assets',
    // 
    //         'models',
    // 
    //         // 'singletons',
    //         // 'collections',
    //     );
    // }

    public function deleteV1stuff() {

        return $this->app->helper('cleanup')->deleteV1stuff();

    }

    public function deleteV2stuff() {

        return $this->app->helper('cleanup')->deleteV2stuff();

    }

    public function migrate($action = 'all', $mode = 'dry-run') {

        $data = ['messages' => []];

        $migrate = $this->app->helper('migrate');

        if ($mode === 'write') {
            $migrate->setState('write');
        }

        $actions = [
            // app
            'roles',
            'accounts',
            'locales',
            'assetsFolders',
            'assets',

            // definitions
            'models',

            // content
            'singletons',
            'collections',
        ];

        foreach ($actions as $method) {

            if ($action !== 'all' && $action !== $method) continue;

            $data[$method] = $migrate->$method();

        }

        $data['messages'] = $migrate->messages;

        return $data;

    }

//     public function test($action = 'all', $mode = 'dry-run') {
// // return compact('action', 'mode');
// // return $this->app->helper('transform-fields')->e_color('rgb(255,255,00)');
// // return $this->app->helper('transform-fields')->e_color('#ffffff');
// 
// 
//         $migrate = $this->app->helper('migrate');
// 
//         if ($mode === 'write') {
//             $migrate->setState('write');
//         }
// 
//         // general stuff
//         // $roles    = $migrate->groups();
//         // $accounts = $migrate->accounts();
//         // $locales  = $migrate->locales();
//         // $assetsFolders = $migrate->assetsFolders();
//         // $assets   = $migrate->assets();
// 
//         // models
//         $models   = $migrate->models();
// 
//         // content
//         // $singletons  = $migrate->singletons();
//         // $collections = $migrate->collections();
// 
//         $messages = $migrate->messages;
// 
//         return compact(
//             // 'messages',
//             // 'roles',
//             // 'accounts',
//             // 'locales',
//             // 'assetsFolders',
//             // 'assets',
// 
//             'models',
// 
//             // 'singletons',
//             // 'collections',
//         );
// 
//     }

}
