# Migrate addon for Cockpit CMS

Migrate and convert models, data, accounts etc. from [Cockpit CMS v1][1] to [v2][2].

This is a first draft from May/June 2023, with some minor cleanup from Sept 2023. Because [I decided not to use Cockpit CMS v2 anymore][3], I won't finish this addon. Maybe it helps as a base or as inspiration for others, so I decided to publish it in my [cockpit-scripts repository][4].

See also [a long list with data comparisons][5] in the same repository.

## Tested with

* v1
  * Cockpit CMS fork ("raffaelj/cockpit") 1.0.0@dev-next
  * PHP 8.1
  * Mongolite (SQLite)
* v2
  * Cockpit CMS 2.5.1
  * PHP 8.1
  * Mongolite (SQLite)

## Concepts

**described concepts are not fully implemented**

Before you start the migration process: **Create a backup!**

Now, that you have a backup, choose a starting point:

1. Your existing installation (v1)
2. A new, empty v2 installation

This addon is compatible with both versions. After installing it, run the following tasks:

1. Cleanup
2. Convert
3. Transform fields
4. Remove outdated artefacts

### from v1

TODO

**UI is partially implemented**

### from v2

**UI is not implemented**

Copy the `config` and `storage` folders into your fresh installation.

You might have to comment out some lines in your `config/bootstrap.php`, if your application throws errors.

## Installation

Copy this repository into `/addons` and name it `Migrate`.

## Copyright and License

Copyright 2023 Raffael Jesche under the MIT license.

[1]: https://github.com/agentejo/cockpit/
[2]: https://github.com/Cockpit-HQ/Cockpit
[3]: https://discourse.getcockpit.com/t/why-i-wont-upgrade-to-cockpit-cms-v2-and-might-leave-the-project/2860
[4]: https://github.com/raffaelj/cockpit-scripts
[5]: https://github.com/raffaelj/cockpit-scripts/blob/master/migrate-from-cockpit-v1-to-v2.md
