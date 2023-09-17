# Migrate Cockpit CMS v1 to v2

Many data formats in Cockpit CMS v2 are different, than in v1. In preparation for writing a migrate script, I collected and compared (most of) them.

Cockpit CMS v1 is compatible with PHP 7.4. If you run `composer update`, it should be compatible with PHP 8.0, which reaches EOL in 2023-11-26.

Because I don't have an alternative for all missing functionalities (yet), I started [a fork of v1](https://codeberg.org/raffaelj/cockpit) with PHP 8.1 compatibility. PHP 8.1 reaches EOL in 2024-11-25. I won't add new features, but I may fix some bugs. The main reason for this fork is to buy some time until all my projects are migrated to Cockpit CMS v2 or to a different system.

Because [I decided not to use Cockpit CMS v2 anymore](https://discourse.getcockpit.com/t/why-i-wont-upgrade-to-cockpit-cms-v2-and-might-leave-the-project/2860), I never finished the Migrate addon. Instead I published my first draft in this scripts repository as well:

https://github.com/raffaelj/cockpit-scripts/tree/master/cockpit-cms-Migrate

## Research/Tutorials

A few people already shared their migration steps:

* https://discourse.getcockpit.com/t/converting-from-v1-to-v2-collections/2718
* https://ronaldaug.medium.com/migrating-cockpit-cms-v1-to-v2-90376a64df22
* https://discourse.getcockpit.com/t/v1-to-v2-migration-and-assets-issues/2775

## Field definitions

### v1 (core)

https://v1.getcockpit.com/documentation/reference/fieldtypes

#### access-list

Field definitions:

```js
{
    "type": "access-list",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": [
        "<user id>",
        "<group name",
    ]
}
```

#### account-link

Field definitions:

```js
{
    "type": "account-link",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<user id>",
}
```

#### asset

Field definitions:

```js
{
    "type": "asset",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": {
        /* all asset properties, see Assets section below */
    },
}
```

#### boolean

Field definitions:

```js
{
    "type": "boolean",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": true|false,
}
```

#### code

Field definitions:

```js
{
    "type": "code",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### collectionlink

TODO

#### collectionlinkselect

TODO

#### color

Field definitions:

```js
{
    "type": "color",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "rgb(255, 255, 0)",
}
```

#### colortag

Field definitions:

```js
{
    "type": "colortag",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "#FFFF00",
}
```

#### date

Field definitions:

```js
{
    "type": "date",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "YYYY-MM-DD",
}
```

#### file

Field definitions:

```js
{
    "type": "file",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "path/to/file.ext", // relative path, TODO: What is the base?
}
```

#### gallery

Field definitions:

```js
{
    "type": "gallery",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": [
        // if selected from "Assets"
        {
            "meta": {
                "asset": "<asset id>",
                "title": "<custom title>",
                // optional: custom meta data
            },
            "path": "/storage/uploads/2023/02/09/img.jpg" // relative path, segment after SITE_URL
        },
        // if selected from "Finder"
        {
            "meta": {
                "title": "<custom title>"
            },
            "path": "/storage/uploads/2023/02/09/img.jpg" // relative path, TODO: What is the base?
        }
    ],
}
```

#### html

Field definitions:

```js
{
    "type": "html",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### image

Field definitions:

```js
{
    "type": "image",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": {
        "path": "storage/uploads/2023/02/09/img.jpg", // TODO: check differences between asset/file/url
    },
}
```

#### layout

TODO

#### layout-grid

TODO

#### location

TODO

#### markdown

Field definitions:

```js
{
    "type": "markdown",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### multipleselect

Field definitions:

```js
{
    "type": "multipleselect",
    "name": "<name>",
    "options": {
        "options": [
            "Option 1",
            "Option 2",
            "Option 3",
        ],
        // alternative as string
        // "options": "Option 1, Option 2, Option 3",
    },
}
```

Data format:

```js
{
    "<name>": [
        "<Option 1>",
        "<Option 2>",
    ]
}
```

#### object

Field definitions:

```js
{
    "type": "object",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": {/* custom content */},
}
```

#### password

Field definitions:

```js
{
    "type": "password",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<hash>",
}
```

#### rating

Field definitions:

```js
{
    "type": "rating",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": 5,
}
```

#### repeater

##### single field

Repeaters with a single field are obsolete in v2. Replace them with the actual field and set it's `multiple` option to `true`. The data format will be different.

I never used the repeater field, because I don't like the data format. If you used the `simple-repeater` alternative from my [custom fields](https://github.com/raffaelj/cockpit-scripts/tree/master/custom-fields), the transformation can be done without modifying the data format.

Field definitions:

```js
{
    "type": "repeater",
    "name": "<name>",
    "options": {
        "field": {
            "type": "text",
            "label": "Title"
        },
        "display": null, // display value on re-order
        "limit": null
    }
}
```

Data format:

```js
{
    "<name>": [
        {
            "value": "<content>",
        },
    ]
}
```

##### multiple fields

Field definitions:

```js
{
    "type": "repeater",
    "name": "<name>",
    "options": {
        "fields": [
            {
                "type": "text",
                "label": "Title"
            },
            {
                "type": "text",
                "label": "Content"
            },
        ],
        "display": null, // display value on re-order
        "limit": null
    }
}
```

Data format:

```js
{
    "<name>": [
        {
            "field": {
                "type": "text",
                "label": "Title"
            },
            "value": "<content>"
        },
        {
            "field": {
                "type": "text",
                "label": "Content"
            },
            "value": "<content>"
        }
    ]
}
```

#### select

Field definitions:

```js
{
    "type": "select",
    "name": "<name>",
    "options": {
        "options": [
            "Option 1",
            "Option 2",
            "Option 3",
        ],
        // alternative as string
        // "options": "Option 1, Option 2, Option 3",
    },
}
```

Data format:

```js
{
    "<name>": "<Option n>",
}
```

#### set

TODO

#### tags

Field definitions:

```js
{
    "type": "tags",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": [
        "<tag 1>",
        "<tag 2>",
        "<tag n>",
    ]
}
```

#### text

Field definitions:

```js
{
    "type": "text",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### textarea

Field definitions:

```js
{
    "type": "textarea",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```



```js
{
    "type": "text",
    "name": "<name>",
    "opts": {
        "multiline": true,
    },
}
```

#### time

Field definitions:

```js
{
    "type": "time",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "HH:mm",
}
```

#### wysiwyg

Field definitions:

```js
{
    "type": "wysiwyg",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<html content>",
}
```

#### collectionlink

TODO

#### collectionlinkselect

TODO

### custom fields (from addons, v1)

#### simple-gallery

TODO

#### seo

TODO

#### key-value-pair

TODO

#### videolink

TODO

### v2 (core)

https://getcockpit.com/documentation/core/concepts/field-types

A new concept of setting a field to `"multiple": true` was introduced in v2. If enabled, all field data formats are stored as an array of field data formats.

Example for a text field:

Field definitions:

```js
{
    "type": "text",
    "name": "<name>",
    "multiple": true|false,
}
```

Data format (`"multiple": false`):

```js
{
    "<name>": "<content>",
}
```

Data format (`"multiple": true`):

```js
{
    "<name>": [
        "<content>",
        "<more content>",
    ],
}
```

#### asset

Field definitions:

```js
{
    "type": "asset",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": {
        /* all asset properties, see Assets section below */
    },
}
```

#### boolean

Field definitions:

```js
{
    "type": "boolean",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": true|false,
}
```

#### code

Field definitions:

```js
{
    "type": "code",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### color

Field definitions:

```js
{
    "type": "color",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "#FFFF00",
}
```

#### contentItemLink

Content item reference

TODO

#### date

Pick a date

Field definitions:

```js
{
    "type": "date",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "YYYY-MM-DD",
}
```

#### datetime

Pick a date & time

Field definitions:

```js
{
    "type": "datetime",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "YYYY-MM-DD HH:mm",
}
```

#### nav

Nested navigation tree

Field definitions:

```js
{
    "type": "nav",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": [
        {
            "active": false,
            "title": "about",
            "url": "/about",
            "target": "",
            "data": [],
            "children": [],
            "meta": []
        }
    ],
}
```

#### number

Quantity etc

Field definitions:

```js
{
    "type": "number",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": 1,
}
```

#### object

Object input

Field definitions:

```js
{
    "type": "object",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": {/* custom content */},
}
```

#### select

Select from a list

Field definitions:

```js
{
    "type": "select",
    "name": "<name>",
    "opts": [
        "multiple": true|false,
        "options": [
            "Option 1",
            "Option 2",
            "Option 3",
    ],
}
```

Data format (opts.multiple = false):

```js
{
    "<name>": "<Option n>",
}
```

Data format (opts.multiple = true):

```js
{
    "<name>": [
        "<Option 1>",
        "<Option 2>",
    ]
}
```

#### set

Set of fields

TODO

#### table

Mangage table data

TODO

#### tags

Field definitions:

```js
{
    "type": "tags",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": [
        "<tag 1>",
        "<tag 2>",
        "<tag n>",
    ]
}
```

#### text

Simple text

Field definitions:

```js
{
    "type": "text",
    "name": "<name>",
    "opts": {
        "multiline": false|true, // textarea if true
    },
}
```

Data format:

```js
{
    "<name>": "<content>",
}
```

#### time

Pick a time

Field definitions:

```js
{
    "type": "time",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "HH:mm",
}
```

#### wysiwyg

Rich text field

Field definitions:

```js
{
    "type": "wysiwyg",
    "name": "<name>",
}
```

Data format:

```js
{
    "<name>": "<html content>",
}
```

## Content definitions

### Singletons

Old structure:

* folder: `#storage:singleton`
* file name: `<name>.singleton.php`
* file structure:

```php
<?php
return [
  'name' => '<name>',
  'label' => '<display name>',
  '_id' => '<name>', // in older versions <name><unique-id>
  '_created' => 1234567890,
  '_modified' => 1234567890,
  'fields' => []
  // 'template' => '', // not sure, if this is an official key or some test data from long ago
  'data' => NULL, // no idea, why this key exists
  'description' => '',
  'icon' => 'settings.svg',
  'color' => '#4FC1E9',
  'acl' => [
    'author' => [
      'form' => true,
    ],
  ],
  // custom fields via addon
];
```

New structure:

* folder: `#storage:content`
* file name: `<name>.model.php`
* file structure:

```php
<?php
return [
  'name' => '<name>',
  'label' => '<display name>',
  '_created' => 1234567890,
  '_modified' => 1234567890,
  'info' => '', // previously "description"
  'type' => 'singleton',
  'fields' => [],
  'preview' => [],
  'group' => '',
  'meta' => NULL,
  'color' => '#4FC1E9',
  'revisions' => false,
  // 'icon' => '', // not implemented, yet?
];
```

### Collections

see Tree structure

### Tree

Old structure:

* folder: `#storage:collections`
* file name: `<name>.collection.php`
* file structure:

```php
<?php
return [
    'name' => '<name>',
    'label' => '<display name>',
    '_id' => '<name>', // in older versions <name><unique-id>
    'fields' => [],
    'sortable' => true, // true: tree, false: collection
    '_created' => 1234567890,
    '_modified' => 1234567890,
    'color' => '#AC92EC',
    'icon' => 'adressbook.svg', // different implementation
    'sort' => [
        'column' => '_created', // default sort order
        'dir' => -1,
    ],
    'contentpreview' => [
        'enabled' => true,
        'url' => '<preview url>',
    ],
    'in_menu' => true, // from old version, no effect anymore
    'acl' => [
        'author' => [
        'entries_view' => true,
        'entries_edit' => true,
        'entries_create' => true,
        'entries_delete' => true,
        ],
    ],
    'rules' => [
        'create' => ['enabled' => false],
        'read' => ['enabled' => false],
        'update' => ['enabled' => false],
        'delete' => ['enabled' => false],
    ],
    // custom fields via addon
];
```

New structure:

* folder: `#storage:content`
* file name: `<name>.model.php`
* file structure:

```php
<?php
return [
    'name' => 'treetest',
    'label' => 'treetest',
    'info' => '',
    'type' => 'tree',
    'fields' => [],
    'preview' => [],
    'group' => '',
    'meta' => NULL,
    '_created' => 1234567890,
    '_modified' => 1234567890,
    'color' => NULL,
    'revisions' => false,
    'preview' => [
        0 => [
        'name' => '<custom name>',
        'uri' => '<preview url>',
        ],
    ],
    // optional meta
    'meta' => [
        'sort' => [
            '_created' => -1, // default sort order
        ],
    ],
];
```

## Data

### Singletons

Old structure:

* Database: `cockpitdb.sqlite`
* Table: `singletons`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "key": "<singleton-name>",
    "val": {
        "_by": "<user-id>",
        "_mby": "<user-id>",
        // field data
        "really": true,
        "title": "My pretty title",
        "title_de": "Mein schöner Titel"
    }
}
```

New structure:

* Database: `content.sqlite`
* Table: `singletons`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_model": "<singleton-name>",
    "_cby": "<user-id>",
    "_mby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "_state": 1, // published state
    // field data
    "really": true,
    "title": "My pretty title",
    "title_de": "Mein schöner Titel"
}
```

### Collections

#### Not sortable

Old structure:

* Database: `collections.sqlite`
* Table: `<collection id>` (same as `<collection name>` or in previous versions `<collection name><unique-id>`)
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_by": "<user-id>",
    "_mby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    // field data
    "really": true,
    "title": "My pretty title",
    "title_de": "Mein schöner Titel"
}
```

New structure:

* Database: `content.sqlite`
* Table: `collections_<collection name>`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_cby": "<user-id>",
    "_mby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "_state": 1,
    // field data
    "really": true,
    "title": "My pretty title",
    "title_de": "Mein schöner Titel"
}
```


#### Sortable

Old structure:

* Database: `collections.sqlite`
* Table: `<collection id>` (same as `<collection name>` or in previous versions `<collection name><unique-id>`)
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_by": "<user-id>",
    "_mby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "_o": 2, // order
    "_pid": null, // <parent-id> or null
    // field data
    "really": true,
    "title": "My pretty title",
    "title_de": "Mein schöner Titel"
}
```

New structure:

* Database: `content.sqlite`
* Table: `collections_<collection name>`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_cby": "<user-id>",
    "_mby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "_o": 2, // order
    "_pid": null, // <parent-id> or null
    "_state": 0,
    // field data
    "really": true,
    "title": "My pretty title",
    "title_de": "Mein schöner Titel"
}
```

#### Trash

Old structure:

* Database: `collections.sqlite`
* Table: `_trash`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_by": "<user-id>",
    "_created": 1234567890,
    "collection": "<collection id>",
    "data": {/* <entry> */}
}
```

New structure:

There is no trash collection for deleted entries in v2. A kind of similar concept is setting the state of an entry to archived (`{"_state": -1}`).

## Forms

V2 core dropped support for forms. The Pro version has a new module called "Inbox", which substitutes the v1 "Forms" module. There is no F(L)OSS alternative (yet).

Old structure:

* Database: `forms.sqlite`
* Table: `<form name>` (in older versions `<form name><unique id>`)
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "data": {
        // form data, e. g.:
        "name": "White rabbit",
        "message": "I have a new follower. Her name is Alice."
    }
}
```

New structure:

I didn't have a look at the Inbox module, because I'm not really interested in proprietary software.

I'm working on porting my FormValiditation addon with some v1 Forms functionality to v2. This may take a while...

TODO

## Accounts/Users

The user api token prefix changed from `account-` to `USR-`. V2 doesn't support custom fields (yet).

Old structure:

* Database: `cockpit.sqlite`
* Table: `accounts`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "active": true,
    "api_key": "account-<token>",
    "email": "<email address>",
    "group": "admin",
    "i18n": "de",
    "name": "<display name>",
    "password": "<password hash>",
    "user": "<user name>"
    // optional: custom fields
}
```

New structure:

* Database: `system.sqlite`
* Table: `users`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "active": true,
    "apiKey": "USR-<token>",
    "email": "<email address>",
    "i18n": "de",
    "name": "<display name>",
    "password": "<password hash>",
    "role": "admin",
    "theme": "auto",
    "twofa": {
        "enabled": false,
        "secret": "<2fa secret>"
    },
    "user": "<user name>"
    // _reset_token
}
```

## Locales

### App

You can use the [Babel addon](https://github.com/raffaelj/cockpit_Babel), but the latest version 0.3.2 is not compatible with Cockpit 2.5.0, because the language folder pattern was refactored.

TODO

### Content

Old structure:

Defined via `config.php`:

```php
<?php return [
    'i18n' => 'en',
    'languages' => [
        'default' => 'English',
        'de'      => 'Deutsch',
    ],
];
```

New structure:

* Database: `system.sqlite`
* Table: `locales`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "enabled": true,
    "i18n": "de",
    "meta": [],
    "name": "Deutsch"
}
```

### Groups/Roles

Research/references:

* https://v1.getcockpit.com/documentation/reference
* https://zeraton.gitlab.io/cockpit-docs/guide/basics/acl.html
* `modules/Cockpit/module/auth.php`, Line 181 `// ACL`

Old structure:

Defined via `config.php`:

```php
<?php return [
    // cockpit user groups settings
    'groups' => [
        '<role name>' => [
            'cockpit' => [
                'backend' => true,
                'assets' => true, // custom ACL from rljUtils addon
            ],
            'forms' => [
                'manage' => true,
            ],
            'editorformats' => [
                'access' => true,
            ],
            'multiplane' => [ // custom ACL from Multiplane addon
                'edit_forms_in_use' => true,
            ],
        ],
    ],
];
```

New structure:

* Database: `system.sqlite`
* Table: `roles`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "appid": "<role name>",
    "info": "",
    "name": "<display name>",
    "permissions": {
        "app/locales/manage": true,
        "app/logs": true,
        "assets/delete": true,
        "assets/edit": true,
        "assets/folders/create": true,
        "assets/folders/delete": true,
        "assets/folders/edit": true,
        "assets/upload": true,
        "content/pages/create": true,
        "content/pages/delete": true,
        "content/pages/publish": true,
        "content/pages/read": true,
        "content/pages/update": true
    }
}
```

## Assets

Old structure:

* Database: `cockpit.sqlite`
* Table: `assets`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_by": "<user-id>",
    "created": 1234567890,
    "modified": 1234567890,
    "image": true,
    "archive": false,
    "audio": false,
    "code": false,
    "document": false,
    "video": false,
    "colors": [
        "#3b352b",
        "#dddadb",
        "#b08772",
        "#846150",
        "#98a07c"
    ],
    "folder": "<folder id>", // or empty string
    "mime": "image/jpeg",
    "path": "/YYYY/MM/DD/<slug of original file name>_uid_<unique-id>.jpg", // in older versions: "/YYYY/MM/DD/<unique-id><slug of original file name>.jpg"
    "size": 123456,
    "tags": [],
    "title": "My cat looks cute",
    "description": "",
    "width": 1920,
    "height": 1080
}
```

New structure:

* Database: `app.sqlite` --> TODO: This should be `assets.sqlite` to be consistent --> see [opened issue](https://github.com/Cockpit-HQ/Cockpit/issues/100)
* Table: `assets`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_cby": "<user-id>",
    "_created": 1234567890,
    "_modified": 1234567890,
    "_hash": "<md5 hash of file contents>",
    "type": "image",
    "colors": [
        "#3b352b",
        "#dddadb",
        "#b08772",
        "#846150",
        "#98a07c"
    ],
    "folder": "<folder id>", // or empty string
    "mime": "image/jpeg",
    "path": "/YYYY/MM/DD/<slug of original file name>_uid_<unique-id>.jpg",
    "size": 123456,
    "tags": [],
    "title": "My cat looks cute",
    "description": "",
    "width": 1920,
    "height": 1080
}
```

### Assets folders

Old structure:

* Database: `cockpit.sqlite`
* Table: `assets_folders`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_p": "<parent-id>", // or empty string
    "_by": "<user-id>", // missing in entries from older versions
    "name": "Cat content"
}
```

New structure:

* Database: `assets.sqlite`
* Table: `folders`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "_p": "<parent-id>", // or empty string
    "_by": "<user-id>",
    "name": "Cat content"
}
```

## Revisions

In v2, revisions are only active, if an entry is published (`"_state: 1`).

Old structure:

* Database: `cockpit.sqlite`
* Table: `revisions`
* Entry structure:

```js
{
    "_created": 1234567890.123456,
    "_creator": "<user-id>",
    "_id": "<unique-id>",
    "_oid": "<entry id>",
    "meta": "singletons/<singleton-id>", // or "collections/<collection-id>"
    "data": {
        "_by": "<user-id>",
        "_mby": "<user-id>",
        // field data
        "really": true,
        "title": "My pretty title",
        "title_de": "Mein schöner Titel"
    },
}
```

New structure:

* Database: `system.sqlite`
* Table: `revisions`
* Entry structure:

```js
{
    "_created": 1234567890,
    "_by": "<user-id>",
    "_id": "<unique-id>",
    "_oid": "<entry id>",
    "meta": "content/<model name>",
    "data": {
        // only field data
        "really": true,
        "title": "My pretty title",
        "title_de": "Mein schöner Titel"
    },
}
```

## Webhooks

Webhooks are one reason, why I chose Cockpit (v1). In the end, I never used them, because I used the PHP api all the time. But it was always good to know, that I could use webhooks to switch from my current implementation to triggering builds of a static site generator (SSG).

In v2, webhooks are part of the Pro version, but I try to avoid proprietary software.

Old structure:

* Database: `cockpit.sqlite`
* Table: `webhooks`
* Entry structure:

```js
{
}
```

TODO

## Api keys

In v1, api keys were defined per route. This concept doesn't seem to exist in v2 anymore. Instead, you have to create roles with the proper permissions and assign api tokens to these roles.

Also tokens have an `API-`prefix now.

This means, that an automated migration of api keys is not possible (or error-prone) and you have to migrate them manually.

Also the user api token prefix changed from `account-` to `USR-`.

Old structure:

* Database: `cockpitdb.sqlite`
* Table: `cockpit`
* Entry structure:

All tokens are in a single entry (key/value store).

```js
{
    "_id": "<unique id>",
    "key": "api_keys",
    "val": {
        "master": "<token>",
        "special": [
            {
                "info": "read pages and posts",
                "rules": "/api/collections/get/pages\n/api/collections/get/posts",
                "token": "<token>"
            },
            {
                "info": "access everything",
                "rules": "*",
                "token": "<token>"
            }
        ]
    }
}
```

New structure:

* Database: `system.sqlite`
* Table: `api_keys`
* Entry structure:

One token per entry.

```js
{
    "_created": 1234567890,
    "_id": "<unique id>",
    "_modified": 1234567890,
    "key": "API-<token>",
    "meta": [], // I don't know, what this is for
    "name": "<name>",
    "role": "<role appid>"
}
```

## Custom data (user data or addon data)

Old structure:

* Database: `cockpit.sqlite`
* Table: `options`
* Entry structure:

```js
{
    "_id": "<unique-id>",
    "key": "dashboard.widgets.<user-id>",
    "val": {
        "collections": {
            "area": "main",
            "prio": 1
        },
        "forms": {
            "area": "aside-right",
            "prio": 1
        },
        "singleton": {
            "area": "aside-left",
            "prio": 1
        }
    }
}
```

New structure:

TODO

## Other

### Jobs queue

Old structure:

* Database: `cockpit.sqlite`
* Table: `jobs_queue`

TODO
