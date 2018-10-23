# List of triggered events in Cockpit CMS

Copy [get-triggers.php](https://github.com/raffaelj/cockpit-scripts/blob/master/cli/get-triggers.php) to `/config/cli/get-triggers.php`.

Content of `triggers.php`, which was created after calling `./cp get-triggers.php` in the console, latest commit in next branch, 2018-10-23:

```php
<?php var_export(array (
  'triggers' => 
  array (
    0 => 'admin.dashboard.bottom',
    1 => 'admin.dashboard.header',
    2 => 'admin.dashboard.top',
    3 => 'admin.dashboard.widgets',
    4 => 'admin.init',
    5 => 'after',
    6 => 'app.layout.contentafter',
    7 => 'app.layout.contentbefore',
    8 => 'app.layout.footer',
    9 => 'app.layout.header',
    10 => 'app.{$controller}.init',
    11 => 'before',
    12 => 'cockpit.account.editview',
    13 => 'cockpit.account.login',
    14 => 'cockpit.account.logout',
    15 => 'cockpit.accounts.save',
    16 => 'cockpit.api.authenticate',
    17 => 'cockpit.api.erroronrequest',
    18 => 'cockpit.api.js',
    19 => 'cockpit.assets.list',
    20 => 'cockpit.assets.remove',
    21 => 'cockpit.assets.save',
    22 => 'cockpit.auth.setuser',
    23 => 'cockpit.bootstrap',
    24 => 'cockpit.clearcache',
    25 => 'cockpit.export',
    26 => 'cockpit.filestorages.init',
    27 => 'cockpit.import',
    28 => 'cockpit.media.removefiles',
    29 => 'cockpit.media.rename',
    30 => 'cockpit.media.upload',
    31 => 'cockpit.menu.aside',
    32 => 'cockpit.menu.main',
    33 => 'cockpit.request.error',
    34 => 'cockpit.rest.init',
    35 => 'cockpit.search',
    36 => 'cockpit.settings.infopage.aside',
    37 => 'cockpit.settings.infopage.main',
    38 => 'cockpit.update.after',
    39 => 'cockpit.update.before',
    40 => 'cockpit.view.settings',
    41 => 'cockpit.view.settings.item',
    42 => 'collections.createcollection',
    43 => 'collections.entry.aside',
    44 => 'collections.find.after',
    45 => 'collections.find.after.{$name}',
    46 => 'collections.find.before',
    47 => 'collections.find.before.{$name}',
    48 => 'collections.remove.after',
    49 => 'collections.remove.after.{$name}',
    50 => 'collections.remove.before',
    51 => 'collections.remove.before.{$name}',
    52 => 'collections.removecollection',
    53 => 'collections.removecollection.{$name}',
    54 => 'collections.save.after',
    55 => 'collections.save.after.{$name}',
    56 => 'collections.save.before',
    57 => 'collections.save.before.{$name}',
    58 => 'collections.updatecollection',
    59 => 'collections.updatecollection.{$name}',
    60 => 'duplicate-entry',
    61 => 'field.layout.components',
    62 => 'forms.save.after',
    63 => 'forms.save.after.{$name}',
    64 => 'forms.save.before',
    65 => 'forms.save.before.{$name}',
    66 => 'forms.submit.after',
    67 => 'forms.submit.before',
    68 => 'init-html-editor',
    69 => 'init-wysiwyg-editor',
    70 => 'ready',
    71 => 'remove-entry',
    72 => 'selectionchange',
    73 => 'shutdown',
    74 => 'singleton.getData.after',
    75 => 'singleton.getData.after.{$name}',
    76 => 'singleton.remove',
    77 => 'singleton.remove.{$name}',
    78 => 'singleton.save.after',
    79 => 'singleton.save.after.{$name}',
    80 => 'singleton.save.before',
    81 => 'singleton.save.before.{$name}',
    82 => 'singleton.saveData.after',
    83 => 'singleton.saveData.after.{$name}',
    84 => 'singleton.saveData.before',
    85 => 'singleton.saveData.before.{$name}',
    86 => 'singletons.form.aside',
    87 => 'sort-update',
    88 => 'submit',
    89 => 'update',
  ),
  'arguments' => 
  array (
    'admin.dashboard.bottom' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/base/dashboard.php',
      ),
    ),
    'admin.dashboard.header' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/base/dashboard.php',
      ),
    ),
    'admin.dashboard.top' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/base/dashboard.php',
      ),
    ),
    'admin.dashboard.widgets' => 
    array (
      'arguments' => 
      array (
        0 => '[$widgets]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Base.php',
      ),
    ),
    'admin.init' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/index.php',
      ),
    ),
    'after' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/lib/Lime/App.php',
      ),
    ),
    'app.layout.contentafter' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'app.layout.contentbefore' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'app.layout.footer' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'app.layout.header' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'app.{$controller}.init' => 
    array (
      'arguments' => 
      array (
        0 => '[$this]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/AuthController.php',
      ),
    ),
    'before' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/lib/Lime/App.php',
      ),
    ),
    'cockpit.account.editview' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/accounts/account.php',
      ),
    ),
    'cockpit.account.login' => 
    array (
      'arguments' => 
      array (
        0 => '[&$user]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Auth.php',
      ),
    ),
    'cockpit.account.logout' => 
    array (
      'arguments' => 
      array (
        0 => '[$this->getUser(',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/module/auth.php',
      ),
    ),
    'cockpit.accounts.save' => 
    array (
      'arguments' => 
      array (
        0 => '[&$data, isset($data[\'_id\']',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Accounts.php',
        1 => 'path/to/cockpit/modules/Cockpit/Controller/RestApi.php',
      ),
    ),
    'cockpit.api.authenticate' => 
    array (
      'arguments' => 
      array (
        0 => '[$data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/rest-api.php',
      ),
    ),
    'cockpit.api.erroronrequest' => 
    array (
      'arguments' => 
      array (
        0 => '[$route, $e->getMessage(',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/rest-api.php',
      ),
    ),
    'cockpit.api.js' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/api.js',
      ),
    ),
    'cockpit.assets.list' => 
    array (
      'arguments' => 
      array (
        0 => '[$assets]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/module/assets.php',
      ),
    ),
    'cockpit.assets.remove' => 
    array (
      'arguments' => 
      array (
        0 => '[$assets]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/module/assets.php',
      ),
    ),
    'cockpit.assets.save' => 
    array (
      'arguments' => 
      array (
        0 => '[&$assets]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/module/assets.php',
      ),
    ),
    'cockpit.auth.setuser' => 
    array (
      'arguments' => 
      array (
        0 => '[&$user, $permanent]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/module/auth.php',
      ),
    ),
    'cockpit.bootstrap' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/bootstrap.php',
      ),
    ),
    'cockpit.clearcache' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/bootstrap.php',
      ),
    ),
    'cockpit.export' => 
    array (
      'arguments' => 
      array (
        0 => '[$options]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/cli/export.php',
      ),
    ),
    'cockpit.filestorages.init' => 
    array (
      'arguments' => 
      array (
        0 => '[&$storages]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/bootstrap.php',
      ),
    ),
    'cockpit.import' => 
    array (
      'arguments' => 
      array (
        0 => '[$options]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/cli/import.php',
      ),
    ),
    'cockpit.media.removefiles' => 
    array (
      'arguments' => 
      array (
        0 => '[$deletions]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Media.php',
      ),
    ),
    'cockpit.media.rename' => 
    array (
      'arguments' => 
      array (
        0 => '[$source, $target]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Media.php',
      ),
    ),
    'cockpit.media.upload' => 
    array (
      'arguments' => 
      array (
        0 => '[$_uploaded, $_failed]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Media.php',
      ),
    ),
    'cockpit.menu.aside' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'cockpit.menu.main' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/layouts/app.php',
      ),
    ),
    'cockpit.request.error' => 
    array (
      'arguments' => 
      array (
        0 => '[\'500\']',
        1 => '[\'401\']',
        2 => '[\'404\']',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/admin.php',
      ),
    ),
    'cockpit.rest.init' => 
    array (
      'arguments' => 
      array (
        0 => '[$routes]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/rest-api.php',
      ),
    ),
    'cockpit.search' => 
    array (
      'arguments' => 
      array (
        0 => '[$query, $list]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Base.php',
      ),
    ),
    'cockpit.settings.infopage.aside' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/settings/info.php',
      ),
    ),
    'cockpit.settings.infopage.main' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/settings/info.php',
      ),
    ),
    'cockpit.update.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$update]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Settings.php',
      ),
    ),
    'cockpit.update.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$update]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/Controller/Settings.php',
      ),
    ),
    'cockpit.view.settings' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/settings/index.php',
      ),
    ),
    'cockpit.view.settings.item' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/views/settings/index.php',
      ),
    ),
    'collections.createcollection' => 
    array (
      'arguments' => 
      array (
        0 => '[$collection]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.entry.aside' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/views/entry.php',
      ),
    ),
    'collections.find.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entries, false]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.find.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entries, false]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.find.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$options, false]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.find.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$options, false]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.remove.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, $result]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.remove.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, $result]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.remove.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$criteria]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.remove.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$criteria]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.removecollection' => 
    array (
      'arguments' => 
      array (
        0 => '[$name]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.removecollection.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.save.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry, $isUpdate]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.save.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry, $isUpdate]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.save.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry, $isUpdate]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.save.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry, $isUpdate]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.updatecollection' => 
    array (
      'arguments' => 
      array (
        0 => '[$collection]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'collections.updatecollection.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$collection]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/bootstrap.php',
      ),
    ),
    'duplicate-entry' => 
    array (
      'arguments' => 
      array (
        0 => '[this.entry, opts.parent]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/assets/entries-tree.tag',
      ),
    ),
    'field.layout.components' => 
    array (
      'arguments' => 
      array (
        0 => '{components:this.components}',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/field-layout.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'forms.save.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'forms.save.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'forms.save.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'forms.save.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$name, &$entry]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'forms.submit.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$form, &$data, $frm]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'forms.submit.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$form, &$data, $frm, &$options]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Forms/bootstrap.php',
      ),
    ),
    'init-html-editor' => 
    array (
      'arguments' => 
      array (
        0 => '[editor]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/field-html.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'init-wysiwyg-editor' => 
    array (
      'arguments' => 
      array (
        0 => '[editor]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/field-wysiwyg.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'ready' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/codemirror.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'remove-entry' => 
    array (
      'arguments' => 
      array (
        0 => '[this.entry]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/assets/entries-tree.tag',
      ),
    ),
    'selectionchange' => 
    array (
      'arguments' => 
      array (
        0 => '[this.selected]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/cp-assets.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components/cp-finder.tag',
        2 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'shutdown' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/lib/Lime/App.php',
      ),
    ),
    'singleton.getData.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, &$data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.getData.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, &$data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.remove' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.remove.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.save.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.save.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.save.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.save.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.saveData.after' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, $data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.saveData.after.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, $data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.saveData.before' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, &$data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singleton.saveData.before.{$name}' => 
    array (
      'arguments' => 
      array (
        0 => '[$singleton, &$data]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/bootstrap.php',
      ),
    ),
    'singletons.form.aside' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Singletons/views/form.php',
      ),
    ),
    'sort-update' => 
    array (
      'arguments' => 
      array (
        0 => '[entries]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/assets/entries-tree.tag',
      ),
    ),
    'submit' => 
    array (
      'arguments' => 
      array (
        0 => '[ed]',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Cockpit/assets/components/field-wysiwyg.tag',
        1 => 'path/to/cockpit/modules/Cockpit/assets/components.js',
      ),
    ),
    'update' => 
    array (
      'arguments' => 
      array (
        0 => '',
      ),
      'files' => 
      array (
        0 => 'path/to/cockpit/modules/Collections/views/collection.php',
        1 => 'path/to/cockpit/modules/Forms/views/form.php',
        2 => 'path/to/cockpit/modules/Singletons/views/singleton.php',
      ),
    ),
  ),
));
```
