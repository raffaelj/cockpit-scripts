<?php
/**
 * Convert data (schemas) from Cockpit CMS v1 to v2
 */

namespace Migrate\Helper;

class Convert extends \Lime\Helper {

    private $isCockpitV2;

    public $permissions;

    // TODO...
    // system:assets/icons/audio.svg
    // system:assets/icons/api.svg
    // system:assets/icons/boolean.svg
    // system:assets/icons/channel.svg
    // system:assets/icons/close.svg
    // system:assets/icons/code.svg
    // system:assets/icons/color.svg
    // system:assets/icons/date.svg
    // system:assets/icons/datetime.svg
    // system:assets/icons/edit.svg
    // system:assets/icons/html.svg
    // system:assets/icons/image.svg
    // system:assets/icons/info.svg
    // system:assets/icons/license.svg
    // system:assets/icons/link.svg
    // system:assets/icons/list.svg
    // system:assets/icons/locales.svg
    // system:assets/icons/lock.svg
    // system:assets/icons/logging.svg
    // system:assets/icons/module.svg
    // system:assets/icons/number.svg
    // system:assets/icons/object.svg
    // system:assets/icons/search.svg
    // system:assets/icons/select.svg
    // system:assets/icons/settings.svg
    // system:assets/icons/spaces.svg
    // system:assets/icons/table.svg
    // system:assets/icons/tags.svg
    // system:assets/icons/text.svg
    // system:assets/icons/time.svg
    // system:assets/icons/users.svg
    // system:assets/icons/video.svg
    // system:assets/icons/wysiwyg.svg
    public $iconMap = [
        'accounts.svg'       => 'system:assets/icons/users.svg',
        'acl.svg'            => 'system:assets/icons/users.svg',
        'adressbook.svg'     => 'system:assets/icons/users.svg',
        'api.svg'            => 'system:assets/icons/api.svg',
        'assets.svg'         => 'system:assets/icons/image.svg',
        'audio.svg'          => 'system:assets/icons/audio.svg',
        'buildings.svg'      => '',
        'business.svg'       => '',
        'button.svg'         => '',
        'calendar.svg'       => 'system:assets/icons/datetime.svg',
        'cart.svg'           => '',
        'clouddocs.svg'      => '',
        'code.svg'           => 'system:assets/icons/code.svg',
        'component.svg'      => '',
        'contacts.svg'       => '',
        'dashboard.svg'      => '',
        'database.svg'       => '',
        'divider.svg'        => '',
        'email.svg'          => '',
        'emoticon-sad.svg'   => '',
        'finder.svg'         => 'finder:icon.svg',
        'food.svg'           => '',
        'form-editor.svg'    => '',
        'gallery.svg'        => 'system:assets/icons/image.svg',
        'game.svg'           => '',
        'gift.svg'           => '',
        'globe.svg'          => '',
        'heading.svg'        => '',
        'horn.svg'           => '',
        'image.svg'          => 'system:assets/icons/image.svg',
        'import.svg'         => '',
        'info.svg'           => 'system:assets/icons/info.svg',
        'items.svg'          => 'system:assets/icons/list.svg',
        'layout.svg'         => '',
        'lighthouse.svg'     => '',
        'lock.svg'           => 'system:assets/icons/lock.svg',
        'login.svg'          => 'system:assets/icons/users.svg',
        'map-marker.svg'     => '',
        'map.svg'            => '',
        'microphone.svg'     => '',
        'module.svg'         => 'system:assets/icons/date.svg',
        'newspaper.svg'      => '',
        'paperplane.svg'     => '',
        'party.svg'          => 'system:assets/icons/users.svg',
        'password-reset.svg' => '',
        'photo.svg'          => 'system:assets/icons/image.svg',
        'play-cubis.svg'     => '',
        'plus-circle.svg'    => '',
        'plus.svg'           => '',
        'post-it.svg'        => 'system:assets/icons/tags.svg',
        'post.svg'           => '',
        'preview.svg'        => '',
        'revisions.svg'      => '',
        'settings.svg'       => 'system:assets/icons/settings.svg',
        'spacer.svg'         => '',
        'sport.svg'          => '',
        'text.svg'           => 'system:assets/icons/text.svg',
        'tickets.svg'        => '',
        'timer.svg'          => 'system:assets/icons/time.svg',
        'video.svg'          => 'system:assets/icons/video.svg',
        'webhooks.svg'       => '',
    ];

    public $aclMap = [

        // Cockpit core
        'cockpit/backend'  => null,
        'cockpit/finder'   => null,
        'cockpit/accounts' => 'app/users/manage',
        'cockpit/settings' => null,
        'cockpit/rest'     => 'app/api/manage',
        'cockpit/webhooks' => null,
        'cockpit/info'     => 'app/system/info',
        'cockpit/unlockresources' => 'app/resources/unlock',

        // Singletons core
        'singletons/create' => 'content/models/manage',
        'singletons/form'   => null,
        'singletons/edit'   => null,
        'singletons/data'   => null,
        'singletons/delete' => 'content/models/manage',
        'singletons/manage' => 'content/models/manage',

        // Collections core
        'collections/create' => 'content/models/manage',
        'collections/delete' => 'content/models/manage',
        'collections/manage' => 'content/models/manage',

        // Forms core
        'forms/create' => null,
        'forms/delete' => null,
        'forms/manage' => null,

        // rljUtils addon
        'cockpit/assets' => [
            'assets/delete',
            'assets/edit',
            'assets/upload',
            'assets/folders/create',
            'assets/folders/delete',
            'assets/folders/edit',
        ],
    ];

    public $contentAclMap = [
        'singleton' => [
            'edit'   => 'content/$name/manage',
            'delete' => 'content/$name/manage',
            'form'   => [
                'content/$name/read',
                'content/$name/update',
                'content/$name/publish',
            ],
            'data'   => 'content/$name/read',
        ],
        'collection' => [
            // 'collection_create' => null, // seems to be an outdated artefact
            'collection_edit' => 'content/$name/manage',
            'entries_view'    => 'content/$name/read',
            'entries_create'  => [
                'content/$name/read',
                'content/$name/create',
                'content/$name/publish',
            ],
            'entries_edit'    => [
                'content/$name/read',
                'content/$name/update',
                'content/$name/publish',
            ],
            'entries_delete'  => [
                'content/$name/read',
                'content/$name/delete',
                'content/$name/publish',
            ],
        ],
        'tree' => [
            // 'collection_create' => null, // seems to be an outdated artefact
            'collection_edit' => 'content/$name/manage',
            'entries_view'    => 'content/$name/read',
            'entries_create'  => [
                'content/$name/read',
                'content/$name/create',
                'content/$name/publish',
            ],
            'entries_edit'    => [
                'content/$name/read',
                'content/$name/update',
                'content/$name/publish',
                'content/$name/updateorder', // only in tree model
            ],
            'entries_delete'  => [
                'content/$name/read',
                'content/$name/delete',
                'content/$name/publish',
            ],
        ],
    ];

    /**
     * Check cockpit version
     *
     * Method is called from parent constructor
     */
    public function initialize() {

        $this->isCockpitV2 = class_exists('Cockpit')
            && defined('APP_VERSION')
            && version_compare(APP_VERSION, '2.0', '>=');

    }

    /**
     * Convert account
     */
    public function account(array $account): array {

        if (isset($account['api_key'])) {
            $account['apiKey'] = preg_replace('/^account/', 'USR', $account['api_key']);
            unset($account['api_key']);
        }

        if ($this->isCockpitV2) {
            $account['twofa'] = [
                'enabled' => false,
                'secret' => $this->app->helper('twfa')->createSecret(160)
            ];
        }

        $account['role'] = $account['group'];
        unset($account['group']);

        return $account;

    }

    /**
     * Convert group to role
     */
    public function group(string $name, array $permissions, bool $extended = false): array {

        $time = time();

        $role = [
            "_created"  => $time,
            "_modified" => $time,
            "appid"     => $name,
            "name"      => $name,
        ];

        $res = $this->convertPermissionsFromGroup($permissions);

        $role['permissions'] = $res['permissions'];

        $role['info'] = $res['info'];

        if (!empty($res['error'])) {
            $role['info'][] = 'error:';
            $role['info'][] = implode("\n", $res['error']);
        }

        $role['info'] = implode("\n", $role['info']);

        return !$extended ? $role : [
            'role'  => $role,
            'info'  => $res['info'],
            'error' => $res['error'],
        ];

    }

    /**
     * Alias for group method
     */
    public function role(string $name, array $permissions, bool $extended = false): array {
        return $this->group($name, $permissions, $extended);
    }

    /**
     * Helper for group method to convert group acl (v1) to role permissions (v2)
     */
    public function convertPermissionsFromGroup(array $data): array {

        $permissions = [];
        $info        = [];
        $error       = [];

        if (isset($data['$admin']) && $data['$admin'] === true) {
            $info[] = 'User group had admin rights in v1. You have to change existing users to role "admin" manually.';
        }
        unset($data['$admin']);

        if (isset($data['$vars'])) {
            $info[] = 'Custom variables are not supported.';
            $info[] = 'Custom vars:';
            $info[] = json_encode($data['$vars']);
        }
        unset($data['$vars']);

        // special cases
        if (isset($data['cockpit']['backend'])) {
            switch ($data['cockpit']['backend']) {
                case true:
                    unset($data['cockpit']['backend']);
                    break;
                case false:
                    $error[] = 'Users without backend access are not supported';
            }
        }
        if (isset($data['cockpit']['finder']) && $data['cockpit']['finder'] === true) {
            $info[] = 'User group had finder access in v1. To grant finder access, a user must have the role "admin" for security reasons.';
        }

        // convert permissions
        foreach ($this->aclMap as $oldPermission => $newPermission) {

            if ($newPermission === null) continue;

            $found = fetchFromArrayAndUnset($data, $oldPermission);

            // not found
            if ($found === null) continue;

            // ignore negative permissions
            if ($found === false) continue;

            if (is_string($newPermission)) {
                $permissions[$newPermission] = $found;
            }
            elseif (is_array($newPermission)) {
                foreach ($newPermission as $k) {
                    $permissions[$k] = $found;
                }
            }

        }

        // clean empty permissions
        $data = array_filter($data, function($v) {
            return !empty($v);
        });

        if (!empty($data)) {
            $info[] = 'Some permissions couldn\'t be converted:';
            $info[] = json_encode($data);
        }

        return compact('error', 'info', 'permissions');

    }

    /**
     * Helper for group method to convert acl from singleton or collection (v1)
     * to content permissions of roles (v2)
     */
    public function collectPermissionsFromModels(string $group, string $type, array $model): array {

        $contentPermissions = [];

        $name = $model['name'];

        if (!isset($model['acl']) || !is_array($model['acl'])) {
            return $contentPermissions;
        }

        if (!isset($model['acl'][$group]) || !is_array($model['acl'][$group])) {
            return $contentPermissions;
        }

        foreach ($model['acl'][$group] as $permission => $value) {

            // ignore negative permissions
            if ($value === false) continue;

            if (isset($this->contentAclMap[$type][$permission])) {

                $arr = $this->contentAclMap[$type][$permission];
                if (is_string($arr)) $arr = [$arr];

                foreach ($arr as $str) {
                    $str = str_replace('$name', $name, $str);
                    $contentPermissions[] = $str;
                }
            }

        }

        return $contentPermissions;

    }

    /**
     * Convert language to locale
     */
    public function locale(string $code, string $label = null): array {

        $time = time();

        $locale = [
            "_created"  => $time,
            "_modified" => $time,
            "enabled"   => true,
            "i18n"      => $code,
            "meta"      => [],
            "name"      => $label ?? $code,
        ];

        return $locale;

    }

    /**
     * Convert asset
     */
    public function asset(array $asset): array {

        $time = time();

        // timestamps
        $asset['_created']  = $asset['created']  ?? $time;
        $asset['_modified'] = $asset['modified'] ?? $time;
        unset($asset['created'], $asset['modified']);

        // type
        $asset['type'] = 'unknown';
        $types = [
            'image',
            'video',
            'audio',
            'archive',
            'document',
            'code',
        ];
        foreach ($types as $type) {
            if (isset($asset[$type]) && $asset[$type] === true) {
                $asset['type'] = $type;
            }
            unset($asset[$type]);
        }

        return $asset;

    }

    /**
     * Convert singleton or collection definitions to model
     */
    public function model(string $type, array $model): array {

        $model['type'] = $type;

        // PHP error if missing
        $model['group'] = $model['group'] ?? '';

        $model['info'] = $model['description'] ?? '';
        unset($model['description']);

        // not needed anymore
        unset($model['_id'], $model['in_menu'], $model['sortable']);

        // icon
        if (!empty($model['icon'])) {
            $model['icon'] = $this->iconMap[$model['icon']];
        }

        // useless keys from outdated versions (Singletons)
        // TODO: check, why these exist
        unset($model['template'], $model['data']);

        // ACL - Make sure to migrate groups before migrating models
        unset($model['acl']);

        // rules
        // TODO: check, if rules files are empty
        unset($model['rules']);

        // revisions were always activated in v1 - enable them for consistency
        $model['revisions'] = true;

        // TODO: transform fields
        $model['fields'] = $this->helper('transform-fields')->convertModelFields($model['fields']);

        // content preview
        // TODO: wsurl, wsprotocols
        $hasPreview = isset($model['contentpreview']) && is_array($model['contentpreview'])
            && isset($model['contentpreview']['enabled'])
            && $model['contentpreview']['enabled'] === true
            && !empty($model['contentpreview']['url']);
        if ($hasPreview) {
            $model['preview'] = [[
                'name' => 'preview',
                'uri'  => $model['contentpreview']['url'],
            ]];
            $infoText = 'Content preview may not work as expected anymore. You have to check that manually.';
            $model['info'] = empty($model['info']) ? $infoText : $model['info'] . "\n\n" . $infoText;
        }
        unset($model['contentpreview']);

        // default sort order (only collections, only in GUI)
        if (isset($model['sort']) && is_array($model['sort'])
            && isset($model['sort']['column']) && isset($model['sort']['dir'])) {

            $column    = $model['sort']['column'];
            $direction = $model['sort']['dir'];

            if ($column !== '_created' && $direction !== -1) {

                $model['meta'] = !isset($model['meta']) || !is_array($model['meta']) ? [] : $model['meta'];

                $model['meta']['sort'][$column] = $direction;
            }
        }
        unset($model['sort']);

        return $model;

    }

    /**
     * Convert singleton data
     */
    public function singletonData(array $entry): array {

        $name = $entry['key'];

        $time = time();

        $entry['_cby'] = $entry['val']['_by']  ?? '';
        $entry['_mby'] = $entry['val']['_mby'] ?? '';
        unset($entry['val']['_by'], $entry['val']['_mby']);

        $entry['_model'] = $name;
        unset($entry['key']);

        $entry['_created']  = $time;
        $entry['_modified'] = $time;

        foreach ($entry['val'] as $k => $v) {
            $entry[$k] = $v;
        }

        unset($entry['val'], $entry['key']);

        // TODO: transform data

        return $entry;

    }

    public function collectionEntry($entry, array $fields = []) {

        // created by
        $entry['_cby'] = $entry['_by'];
        unset($entry['_by']);

        // set default state to "published"
        $entry['_state'] = $entry['_state'] ?? 0;

        // TODO: transform assets

        $this->app->trigger('migrate.collection.entry', [&$entry, $fields]);

        return $entry;

    }

}

// helper functions

/**
 * Helper function for acl/permissions mapping
 * variant of `\Lime\fetch_from_array`, that also unsets the found array key
 */
function fetchFromArrayAndUnset(&$array, $index = null, $default = null) {

    if (is_null($index)) {

        $v = $array;
        unset($array);
        return $v;

    } elseif (isset($array[$index])) {

        $v = $array[$index];
        unset($array[$index]);
        return $v;

    } elseif (\strpos($index, '/')) {

        $keys = \explode('/', $index);

        switch (\count($keys)){

            case 1:
                if (isset($array[$keys[0]])){
                    $v = $array[$keys[0]];
                    unset($array[$keys[0]]);
                    return $v;
                }
                break;

            case 2:
                if (isset($array[$keys[0]][$keys[1]])){
                    $v = $array[$keys[0]][$keys[1]];
                    unset($array[$keys[0]][$keys[1]]);
                    return $v;
                }
                break;

            case 3:
                if (isset($array[$keys[0]][$keys[1]][$keys[2]])){
                    $v = $array[$keys[0]][$keys[1]][$keys[2]];
                    unset($array[$keys[0]][$keys[1]][$keys[2]]);
                    return $v;
                }
                break;

            case 4:
                if (isset($array[$keys[0]][$keys[1]][$keys[2]][$keys[3]])){
                    $v = $array[$keys[0]][$keys[1]][$keys[2]][$keys[3]];
                    unset($array[$keys[0]][$keys[1]][$keys[2]][$keys[3]]);
                    return $v;
                }
                break;
        }
    }

    return \is_callable($default) ? \call_user_func($default) : $default;
}
