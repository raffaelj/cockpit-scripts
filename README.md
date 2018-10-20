# Useful scripts and snippets for Cockpit CMS

A collection of code snippets with annotations to modify [Cockpit CMS](https://github.com/agentejo/cockpit)

## Privacy and security related snippets

* [restrict-built-in-helpers/bootstrap.php](https://github.com/raffaelj/cockpit-scripts/blob/master/restrict-built-in-helpers/bootstrap.php)
* [custom-api-endpoints/listUsers.php](https://github.com/raffaelj/cockpit-scripts/blob/master/custom-api-endpoints/listUsers.php)

And please update to Version 0.8.2 or above. There were a few securitiy fixes for the backend and for the api.

## Informations about Cockpit

It was a bit confusing in the past, to find the right places for informations or to ask for help.

* [Cockpit Community Forum](https://discourse.getcockpit.com/) --> the place to ask for help
* [Official Docs](https://getcockpit.com/documentation) --> needs some help to get up to date
* [Github Issues](https://github.com/agentejo/cockpit/issues)
* read the code --> it's interesting and there are a lot of hidden features

### outdated

* [Wiki on Github](https://github.com/agentejo/cockpit/wiki) --> a few code snippets
* [Gitter Chat](https://gitter.im/COCOPi/cockpit)
* [Google+ User Group](https://plus.google.com/communities/114909939320646034687)
* [Docs on COCOPI](https://github.com/COCOPi/cockpit-docs) --> outdated, it was for the old legacy branch
* [Awesome Cockpit](https://github.com/muoto/awesome-cockpit) --> a few links
* [Cockpit CMS Addon List](https://github.com/muoto/CockpitCMSAddons) --> not complete

## Cockpit Addons

Curated [List of Cockpit Addons](https://discourse.getcockpit.com/t/list-of-cockpit-addons/234) in the Community Forum

### Addons, I wrote

Most of them are "work in progress". Feel free to contribute.

#### [SelectRequestOptions](https://github.com/raffaelj/cockpit_SelectRequestOptions)

Select field with options based on (custom) requests

#### [FormValidation](https://github.com/raffaelj/cockpit_FormValidation)

Form builder and form validator

* supports honeypot and content validation to trick spam bots

#### [Feed](https://github.com/raffaelj/cockpit_Feed)

RSS Feed output for collections

#### [UniqueSlugs](https://github.com/raffaelj/cockpit_UniqueSlugs)

Create unique slugs if you don't want the `_id` as unique identifier.

* supports slug generation of nested fields

#### [ModuleLink](https://github.com/raffaelj/cockpit_ModuleLink)

Create and populate whole modules instead of single collection entries.

#### [MoreOptions](https://github.com/raffaelj/cockpit_MoreOptions)

Test addon, some more features for collections, may change completely over time
