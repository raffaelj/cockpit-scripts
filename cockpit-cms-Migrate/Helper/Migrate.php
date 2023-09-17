<?php

namespace Migrate\Helper;

class Migrate extends \Lime\Helper {

    // TODO: input dir
    // TODO: output dir

    private $isCockpitV2;

    public $dryRun = true;

    public $messages = [];

    // Internal converter class
    private $convert;

    public $allowUpdatingAccounts = false;
    public $allowUpdatingRoles    = false;
    public $allowUpdatingLocales  = false;
    public $allowUpdatingAssets   = false;
    public $allowUpdatingAssetsFolders = false;
    public $allowUpdatingModels   = false;
    public $allowUpdatingEntries  = false;

    /**
     * Take care of v1/v2 specifics and load convert helper
     *
     * Method is called from parent constructor
     */
    public function initialize() {

        $this->isCockpitV2 = class_exists('Cockpit')
            && defined('APP_VERSION')
            && version_compare(APP_VERSION, '2.0', '>=');

        if (!$this->isCockpitV2) {
            $this->app->service('dataStorage', function() {
                return $this->app->storage;
            });
        }

        $this->convert = new Convert($this->app);

    }

    /**
     * Change state to "write" or "dry-run"
     */
    public function setState(string $state = 'dry-run') {

        switch ($state) {

            case 'write':
                $this->dryRun = false;
                $this->messages[] = 'Set migrate state to write';
                break;
            default:
                $this->dryRun = true;
                $this->messages[] = 'Set migrate state to dry-run';

        }

        return $this;
    }

    /**
     * Migrate accounts
     */
    public function accounts(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'system/users';

        $accounts = $this->app->dataStorage->find('cockpit/accounts')->toArray();

        foreach ($accounts as $account) {

            $user = $this->convert->account($account);

            $filter = [
                '$or' => [
                    ['_id'  => $user['_id']],
                    ['user' => $user['user']],
                ]
            ];
            $userExists = $this->app->dataStorage->findOne($store, $filter);

            if (!$userExists) {
                $created[] = $user;
            }
            elseif ($this->allowUpdatingAccounts) {
                $updated[] = $user;
            }
            else {
                $skipped[] = $user;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $user) {
                $this->app->dataStorage->insert($store, $user);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingAccounts) {
            foreach ($updated as $user) {
                unset($user['_created']);
                $this->app->dataStorage->save($store, $user);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Migrate groups and access control lists (acl) to roles and permissions
     *
     * Groups in v1 are defined in #config:config.php, but roles in v2 are
     * stored in a database.
     *
     * Permissions in v1 are also defined in collection/singleton definition files
     */
    public function groups(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'system/roles';

        $modelGroups = $this->getModels();

        $groups = $this->app->retrieve('groups', []);

        foreach ($groups as $group => $permissions) {

            if ($group === 'admin') continue;

            $res = $this->convert->group($group, $permissions, true);

            $role = $res['role'];

            $hasErrors = !empty($res['error']);

            // add content permissions
            foreach ($modelGroups as $type => $models) {

                foreach ($models as $model) {

                    $res = $this->convert->collectPermissionsFromModels($group, $type, $model);

                    foreach ($res as $v) {
                        $role['permissions'][$v] = true;
                    }
                }
            }

            $roleExists = $this->app->dataStorage->findOne($store, ['appid' => $role['appid']]);

            if (!$hasErrors && !$roleExists) {
                $created[] = $role;
            }
            elseif (!$hasErrors && $this->allowUpdatingRoles) {
                $updated[] = $role;
            }
            else {
                $skipped[] = $role;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $role) {
                $this->app->dataStorage->insert($store, $role);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingAccounts) {
            foreach ($updated as $role) {
                unset($role['_created']);
                $this->app->dataStorage->save($store, $role);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Alias for groups
     */
    public function roles(): array {
        return $this->groups();
    }

    /**
     * Migrate languages to locales
     *
     * Languages in v1 are defined in #config:config.php, but locales in v2 are
     * stored in a database.
     */
    public function locales(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'system/locales';

        $languages = $this->app->retrieve('languages', []);

        foreach ($languages as $code => $label) {

            // 'i18n' = 'default' is allowed in v2
            // if ($code === 'default') continue;

            $locale = $this->convert->locale($code, $label);

            $localeExists = $this->app->dataStorage->findOne($store, ['i18n' => $code]);

            if (!$localeExists) {
                $created[] = $locale;
            }
            elseif ($this->allowUpdatingLocales) {
                $updated[] = $locale;
            }
            else {
                $skipped[] = $locale;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $locale) {
                $this->app->dataStorage->insert($store, $locale);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingLocales) {
            foreach ($updated as $locale) {
                unset($locale['_created']);
                $this->app->dataStorage->save($store, $locale);
            }
        }

        if (!$this->dryRun && $this->isCockpitV2) {
            //reset cache
            $this->app->helper('locales')->cache();
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Copy assets folders - no conversion needed
     */
    public function assetsFolders(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'assets/folders';

        $assetsFolders = $this->app->dataStorage->find('cockpit/assets_folders')->toArray();

        $folders = [];

        foreach ($assetsFolders as $folder) {

            $folderExists = $this->app->dataStorage->findOne($store, ['_id' => $folder['_id']]);

            if (!$folderExists) {
                $created[] = $folder;
            }
            elseif ($this->allowUpdatingAssetsFolders) {
                $updated[] = $folder;
            }
            else {
                $skipped[] = $folder;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $folder) {
                $this->app->dataStorage->insert($store, $folder);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingAssetsFolders) {
            foreach ($updated as $folder) {
                $this->app->dataStorage->save($store, $folder);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Migrate assets
     */
    public function assets() {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'app/assets';

        $assets = $this->app->dataStorage->find('cockpit/assets')->toArray();

        foreach ($assets as $asset) {

            $asset = $this->convert->asset($asset);

            $assetExists = $this->app->dataStorage->findOne($store, ['_id' => $asset['_id']]);

            if (!$assetExists) {
                $created[] = $asset;
            }
            elseif ($this->allowUpdatingAssets) {
                $updated[] = $asset;
            }
            else {
                $skipped[] = $asset;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $asset) {
                $this->app->dataStorage->insert($store, $asset);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingAssets) {
            foreach ($updated as $asset) {
                unset($asset['_created']);
                $this->app->dataStorage->save($store, $asset);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Migrate collections and singletons to models
     */
    public function models(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $modelGroups = $this->getModels();

        foreach ($modelGroups as $type => $models) {
            foreach ($models as $name => $model) {

                $model = $this->convert->model($type, $model);

                $modelExists = $this->app->path("#storage:content/{$name}.model.php");

                if (!$modelExists) {
                    $created[] = $model;
                }
                elseif ($this->allowUpdatingModels) {
                    $updated[] = $model;
                }
                else {
                    $skipped[] = $model;
                }

            }
        }

        if (!$this->dryRun) {
            foreach ($created as $model) {
                $this->writeModel($model);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingModels) {
            foreach ($updated as $model) {
                $this->writeModel($model);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * List collections and singletons as models by type
     */
    public function getModels(): array {

        $singleton  = [];
        $collection = [];
        $tree       = [];

        foreach ($this->app->helper("fs")->ls('*.singleton.php', '#storage:singleton') as $path) {

            $model = include($path->getPathName());
            $singleton[$model['name']] = $model;

        }

        foreach ($this->app->helper("fs")->ls('*.collection.php', '#storage:collections') as $path) {

            $model = include($path->getPathName());

            $isSortable = isset($model['sortable']) && $model['sortable'] === true;

            if ($isSortable) {
                $tree[$model['name']] = $model;
            }
            else {
                $collection[$model['name']] = $model;
            }

        }

        return compact('singleton', 'collection', 'tree');

    }

    /**
     * Save model in "#storage:content/{$name}.model.php"
     */
    public function writeModel(array $model): void {

        $storagepath = $this->app->path('#storage:').'/content';

        if (!$this->app->path('#storage:content')) {

            if (!$this->app->helper('fs')->mkdir($storagepath)) {
                $this->messages[] = [
                    'job' => 'write model',
                    'error' => 'Could not create #storage:content folder',
                    'data' => $model,
                ];
            }
        }

        $name = $model['name'];

        $export = $this->app->helper('utils')->var_export($model, true);

        if (!$this->app->helper('fs')->write("#storage:content/{$name}.model.php", "<?php\n return {$export};")) {
            $this->messages[] = [
                'job' => 'write model',
                'error' => 'Could not create model file',
                'data' => $model,
            ];
        }

    }

    /**
     * Migrate data from singletons
     */
    public function singletons(): array {

        $created = [];
        $updated = [];
        $skipped = [];

        $store = 'content/singletons';

        $modelGroups = $this->getModels();
        $singletons  = $modelGroups['singleton'];

        $dataSets = $this->app->dataStorage->find('cockpitdb/singletons')->toArray();

        foreach ($dataSets as $entry) {

            // TODO: skip, if orphan (no model exists)

            $entry = $this->convert->singletonData($entry);

            $isOrphan = !isset($singletons[$entry['_model']]);

            if ($isOrphan) {
                $this->messages[] = [
                    'job' => 'convert singleton data',
                    'error' => 'dataset has no model',
                    'data' => [
                        'store' => $store,
                        'name'  => $entry['_model'],
                        '_id'   => $entry['_id'],
                    ],
                ];
            }

            $singletonExists = $this->app->dataStorage->findOne($store, ['_id' => $entry['_id']]);

            if (!$singletonExists && !$isOrphan) {
                $created[] = $entry;
            }
            elseif ($this->allowUpdatingEntries && !$isOrphan) {
                $updated[] = $entry;
            }
            else {
                $skipped[] = $entry;
            }

        }

        if (!$this->dryRun) {
            foreach ($created as $entry) {
                $this->app->dataStorage->insert($store, $entry);
            }
        }

        if (!$this->dryRun && $this->allowUpdatingEntries) {
            foreach ($updated as $entry) {
                unset($entry['_created']);
                $this->app->dataStorage->save($store, $entry);
            }
        }

        return compact('created', 'updated', 'skipped');

    }

    /**
     * Migrate data from all collections
     */
    public function collections(string $collection = null): array {

        // $created = [];
        // $updated = [];
        // $skipped = [];

        $collections = [];

        $storePattern = 'content/collections/$name';

        $modelGroups = $this->getModels();

        $types = ['collection', 'tree'];
        foreach ($types as $type) {
            foreach ($modelGroups[$type] as $name => $model) {

                if ($collection && $collection !== $name) {
                    continue;
                }

                $entries = $this->collection($model);

                $collections[$name] = $entries;

                if (!$this->dryRun) {

                    $store = str_replace('$name', $name, $storePattern);

                    foreach ($entries as $entry) {

                        $entryExists = $this->app->dataStorage->findOne($store, ['_id' => $entry['_id']]);

                        if (!$entryExists) {
                            $this->app->dataStorage->insert($store, $entry);
                        }
                        else {
                            $this->app->dataStorage->save($store, $entry);
                        }

                    }

                }

            }
        }

        return $collections;

        // return compact('created', 'updated', 'skipped');

    }

    /**
     * Migrate data from one collection
     */
    public function collection(array $model): array {

        $name   = $model['name'];
        $id     = $model['_id'] ?? $model['name'];
        $fields = $model['fields'] ?? [];

        $storePattern = 'content/collections/$name';

        $entries = $this->app->dataStorage->find("collections/{$id}")->toArray();

        foreach ($entries as &$entry) {
            $entry = $this->convert->collectionEntry($entry, $fields);
        }

        return $entries;

    }

    // TODO: api keys --> can not be automated
    // TODO: revisions
    // TODO: trash

}
