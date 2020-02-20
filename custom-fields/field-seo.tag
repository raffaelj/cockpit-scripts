/**
 * SEO field for Cockpit CMS
 * 
 * @version   0.1.2
 * @author    Raffael Jesche
 * @license   MIT
 * 
 * @see       https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-seo.tag
 * @see       https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-seo.md
 * 
 * @requires key-value-pair field
 * @see       https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-key-value-pair.tag
 * @see       https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-key-value-pair.md
 */

<field-seo>

    <style>
        .uk-block-muted {
            background-color: rgba(0,0,0,.01);
            padding: .5em;
        }
    </style>

    <div>

        <cp-seo-field-sidebar bind="config"></cp-seo-field-sidebar>

        <div class="uk-grid uk-grid-gutter uk-grid-match">

            <div class="uk-width-1-1" if="{ !hide.title }">

                <cp-fieldcontainer>
                    <div class="uk-flex uk-flex-middle">
                        <label class="uk-text-bold">
                            { App.i18n.get('Meta title') }
                        </label>
                        <span class="uk-flex-item-1"></span>
                        <cp-seo-field-length source="title" with-branding="1"></cp-seo-field-length>
                        <cp-seo-field-score source="title"></cp-seo-field-score>
                    </div>

                    <div class="uk-flex uk-flex-middle">
                        <input class="uk-width-1-1" type="text" bind="seo.title" />
                        <span class="uk-text-muted uk-text-nowrap" if="{ config.addBranding }">{ config.spacer.replace(/\s/g, '&nbsp;') + config.branding }</span>
                    </div>

                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        { App.i18n.get('min: 25, good: 35-65, max: 75') } |
                        { App.i18n.get('optimal for all three combined:') }
                        { App.i18n.get('min: 25, good: 35-65, max: 70') }
                    </div>

                    <cp-seo-field-guess source="title" target="title" with-branding="1"></cp-seo-field-guess>

                </cp-fieldcontainer>
            </div>

            <div class="uk-width-large-1-2" if="{ !hide.description }">
                <cp-fieldcontainer>
                    <div class="uk-flex uk-flex-middle">
                        <label class="uk-text-bold">
                            { App.i18n.get('Meta description') }
                        </label>
                        <span class="uk-flex-item-1"></span>
                        <cp-seo-field-length source="description"></cp-seo-field-length>
                        <cp-seo-field-score source="description"></cp-seo-field-score>
                    </div>

                    <div class="">
                        <textarea rows="4" class="uk-width-1-1" bind="seo.description" bind-event="input"></textarea>
                    </div>

                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        { App.i18n.get('min: 45, good: 80-160, max: 320') } |
                        { App.i18n.get('optimal for all three combined:') }
                        { App.i18n.get('min: 45, good: 80-160, max: 200') }
                    </div>

                    <cp-seo-field-guess source="description"></cp-seo-field-guess>

                </cp-fieldcontainer>
            </div>

            <div class="uk-width-large-1-2">
                <cp-fieldcontainer>
                    <label class="uk-text-bold">
                        { App.i18n.get('Social images') }
                    </label>
                    <field-gallery bind="seo.image" meta="{ imageOpts }"></field-gallery>
                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        <p>{ App.i18n.get('optimal resolution: 1.91:1, optimal min width: 1200px') }<br>
                        { App.i18n.get('If you use multiple images, the first one will be used as twitter:image.') }</p>
                    </div>

                    <div class="uk-block-muted uk-panel-card uk-border-rounded uk-margin-small-top uk-flex uk-flex-middle" if="{ fallback.image && guess.image }">

                        <div class="" if="{ guess.image && guess.image._id }">
                          <cp-thumbnail src="{guess.image._id}" width="100" height="100"></cp-thumbnail>
                        </div>

                        <div class="uk-flex uk-flex-middle uk-flex-space-around" if="{ guess.image && guess.image[0] && guess.image[0].meta.asset }">
                            <div each="{ img in guess.image }">
                              <cp-thumbnail src="{img.meta.asset}" width="100" height="100"></cp-thumbnail>
                            </div>
                        </div>

                        <span class="uk-flex-item-1"></span>

                        <div>
                            <i class="uk-icon uk-icon-question-circle uk-text-muted" title="{ App.i18n.get('Source field:') } { $root.fieldsidx[fallback.image].label || fallback.image }" data-uk-tooltip></i>
                            <a class="uk-icon-copy uk-icon-hover" href="#" data-source="image" onclick="{ copyContent }" if="{ guess.image }" title="{ App.i18n.get('Copy content from image field') }" data-uk-tooltip></a>
                        </div>
                    </div>

                </cp-fieldcontainer>
            </div>

            <div class="uk-width-medium-1-2" if="{ advanced }">

                <label class="uk-text-bold">
                    { App.i18n.get('Open Graph meta tags') }
                </label>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                        <div class="uk-flex uk-flex-middle">
                            <label class="uk-text-bold">
                                og:title
                            </label>

                            <span class="uk-flex-item-1"></span>

                            <span class="uk-text-muted uk-text-small uk-margin-right" if="{ seo.og && seo.og[0] && seo.og[0].title }">{ (seo.og[0].title + (config.addBranding ? config.spacer + config.branding: '')).length }</span>

                            <cp-seo-field-score source="og.0.title"></cp-seo-field-score>
                        </div>

                         <div class="uk-flex uk-flex-middle">
                            <input class="uk-width-1-1" type="text" bind="seo.og.0.title" />
                            <span class="uk-text-muted uk-text-nowrap" if="{ config.addBranding }">{ config.spacer.replace(/\s/g, '&nbsp;') + config.branding }</span>
                        </div>
                        <div class="uk-margin-top uk-text-small uk-text-muted">
                            { App.i18n.get('min: 15, good: 25-88, max: 100') }
                        </div>
                        <cp-seo-field-guess source="og.0.title" target="og.0.title" with-branding="1"></cp-seo-field-guess>
                    </cp-fieldcontainer>
                </div>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                        <div class="uk-flex uk-flex-middle">
                            <label class="uk-text-bold">
                                og:description
                            </label>

                            <span class="uk-flex-item-1"></span>

                            <span class="uk-text-muted uk-text-small uk-margin-right" if="{ seo.og && seo.og[1] && seo.og[1].description }">{ seo.og[1].description.length }</span>

                            <cp-seo-field-score source="og.1.description"></cp-seo-field-score>
                        </div>

                        <div class="uk-margin-top">
                            <textarea rows="4" class="uk-width-1-1" bind="seo.og.1.description" bind-event="input"></textarea>
                        </div>
                        <div class="uk-margin-top uk-text-small uk-text-muted">
                            { App.i18n.get('min: 45, good: 80-200, max: 300') }
                        </div>
                        <cp-seo-field-guess source="og.1.description" target="og.1.description"></cp-seo-field-guess>
                    </cp-fieldcontainer>
                </div>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                        <label class="uk-text-bold">
                            { App.i18n.get('Custom Open Graph meta tags') }
                        </label>
                        <div class="uk-margin-top">
                            <field-key-value-pair bind="og" format="array" display-prefix="og:"></field-key-value-pair>
                        </div>
                    </cp-fieldcontainer>
                </div>

            </div>

            <div class="uk-width-medium-1-2" if="{ advanced }">

                <label class="uk-text-bold">
                    { App.i18n.get('Twitter meta tags') }
                </label>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                        <div class="uk-flex uk-flex-middle">
                            <label class="uk-text-bold">
                            twitter:title
                            </label>

                            <span class="uk-flex-item-1"></span>

                            <span class="uk-text-muted uk-text-small uk-margin-right" if="{ seo.twitter && seo.twitter.title }">{ (seo.twitter.title + (config.addBranding ? config.spacer + config.branding: '')).length }</span>

                            <cp-seo-field-score source="twitter.title"></cp-seo-field-score>
                        </div>

                         <div class="uk-flex uk-flex-middle">
                            <input class="uk-width-1-1" type="text" bind="seo.twitter.title" />
                            <span class="uk-text-muted uk-text-nowrap" if="{ config.addBranding }">{ config.spacer.replace(/\s/g, '&nbsp;') + config.branding }</span>
                        </div>

                        <div class="uk-margin-top uk-text-small uk-text-muted">
                            { App.i18n.get('min: 15, good: 25-69, max: 70') }
                        </div>
                        <cp-seo-field-guess source="twitter.title" target="twitter.title" with-branding="1"></cp-seo-field-guess>
                    </cp-fieldcontainer>
                </div>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                    <div class="uk-flex uk-flex-middle">
                        <label class="uk-text-bold">
                            twitter:description
                        </label>

                        <span class="uk-flex-item-1"></span>

                        <span class="uk-text-muted uk-text-small uk-margin-right" if="{ seo.twitter && seo.twitter.description }">{ seo.twitter.description.length }</span>

                        <cp-seo-field-score source="twitter.description"></cp-seo-field-score>
                    </div>

                    <div class="uk-margin-top">
                        <textarea rows="4" class="uk-width-1-1" bind="seo.twitter.description" bind-event="input"></textarea>
                    </div>

                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        { App.i18n.get('min: 45, good: 80-200, max: 200') }
                    </div>
                    <cp-seo-field-guess source="twitter.description" target="twitter.description"></cp-seo-field-guess>
                    </cp-fieldcontainer>
                </div>

                <div class="uk-width-1-1 uk-margin-top">
                    <cp-fieldcontainer>
                    <label class="uk-text-bold">
                        { App.i18n.get('Custom Twitter meta tags') }
                    </label>
                    <div class="uk-margin-top">
                        <field-key-value-pair bind="twitter" display-prefix="twitter:"></field-key-value-pair>
                    </div>
                    </cp-fieldcontainer>
                </div>

            </div>

            <div class="uk-width-medium-1-2" if="{ advanced }">
                <cp-fieldcontainer>
                    <label class="uk-text-bold">
                        { App.i18n.get('Robots meta tags') }
                    </label>
                    <div class="uk-margin-top">
                        <cp-field type="tags" bind="seo.robots" opts="{ robotsOpts }"></cp-field>
                    </div>
                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        { App.i18n.get('noindex, nofollow...') }
                    </div>
                </cp-fieldcontainer>

            </div>

            <div class="uk-width-medium-1-2" if="{ advanced && !hide.canonical }">
                <cp-fieldcontainer>
                    <label class="uk-text-bold">
                        { App.i18n.get('Canonical') }
                    </label>
                    <div class="uk-margin-top">
                        <input type="text" bind="seo.canonical" class="uk-width-1-1" />
                    </div>
                    <div class="uk-margin-top uk-text-small uk-text-muted">
                        { App.i18n.get('Set a custom canonical url') }
                    </div>
                </cp-fieldcontainer>

            </div>

        </div>
    </div>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.seo    = {};
        this.guess  = {};
        this.combined = {};
        this.status = {};

        this.config = {};
        this.defaultConfig = {};

        this.og = [];
        this.twitter = {};

        this.lang = '';
        this.localize = {title: false, description: false, image: false};

        this.advanced = false;
        this.hide     = {};

        this.spacer = '';
        this.branding = '';

        this.fallback = {};

        this.$root = null;
        this.entryName = ''; // collection: 'entry', singleton: 'data'
        this.isCollection = false;
        this.isSingleton  = false;

        this.on('mount', function() {

            this.advanced  = opts.advanced  || false;
            this.hide      = opts.hide      || {};
            this.fallback  = opts.fallback  || {};

            this.fallback['og.0.title'] = this.fallback['twitter.title'] = 'seo.title';
            this.fallback['og.1.description'] = this.fallback['twitter.description'] = 'seo.description';

            this.defaultConfig = {
                addBranding: true,
                spacer: opts.spacer || ' - ',
                branding: opts.branding || ''
            };

            App.$.extend(this.config, this.defaultConfig);

            if (App.Utils.isObject(this.seo.config) && !Array.isArray(this.seo.config)) {
                App.$.extend(this.config, this.seo.config);
            }

            if (this.seo.og && this.seo.og.length) {
                this.og = this.seo.og.slice(2);
            }

            if (this.seo.twitter && Object.keys(this.seo.twitter).length) {
                this.twitter = Object.assign({}, this.seo.twitter);
                delete this.twitter.title;
                delete this.twitter.description;
            }

            this.$root   = this.getRoot();
            this.group   = this.$root.fieldsidx && this.$root.fieldsidx.seo
                           ? this.$root.fieldsidx.seo.group : 'Main'; // to do: check for current field name

            if (this.fallback.title && this.$root.fieldsidx[this.fallback.title]) {
                this.localize.title = this.$root.fieldsidx[this.fallback.title].localize || false;
            }
            if (this.fallback.description && this.$root.fieldsidx[this.fallback.description]) {
                this.localize.description = this.$root.fieldsidx[this.fallback.description].localize || false;
            }
            if (this.fallback.image && this.$root.fieldsidx[this.fallback.image]) {
                this.localize.image = this.$root.fieldsidx[this.fallback.image].localize || false;
            }

            var sidebar = this.isCollection ? App.$('> .uk-grid > div:last-child', this.$root.root).get(0)
                   : (this.isSingleton  ? App.$('> div > .uk-grid > div:last-child', this.$root.root).get(0)
                   : null);

            if (sidebar) App.$(sidebar).prepend(App.$('cp-seo-field-sidebar'));

            // remove parent field container (experimental)
            if (opts.container === false) {
                var container = App.$(this.root).closest('cp-fieldcontainer').get(0);
                if (container) {
                    App.$(container.parentNode).append(container.children);
                    container.parentNode.removeChild(container);
                }
                delete container;
            }

        });

        this.on('update', function() {

            this.lang = this.$root.lang;

            if (this.fallback.title) {
                var name = this.fallback.title;
                if (this.lang && this.localize.title) name += '_' + this.lang;
                this.guess.title = this.$root[this.entryName][name];
            }

            if (this.fallback.description) {
                var name = this.fallback.description;
                if (this.lang && this.localize.description) name += '_' + this.lang;
                this.guess.description = this.truncate(App.Utils.stripTags(
                                         this.$root[this.entryName][name]), 400);
            }

            if (this.fallback.image) {
                var name = this.fallback.image;
                if (this.lang && this.localize.image) name += '_' + this.lang;
                this.guess.image = this.$root[this.entryName][name];
            }

            this.guess['og.0.title']    = this.seo.title || this.guess.title;
            this.guess['twitter.title'] = this.seo.title || this.guess.title;
            this.guess['og.1.description']    = this.seo.description || this.guess.description;
            this.guess['twitter.description'] = this.seo.description || this.guess.description;

            App.$.extend(this.combined, this.guess);

            App.$.each(this.guess, function(k,v) {
                var obj = $this.seo, path = k, i;
                path = path.split('.');
                for (i = 0; i < path.length - 1; i++) {
                    if (obj.hasOwnProperty(path[i])) {
                        obj = obj[path[i]];
                    } else {break;}
                }

                if (obj && obj[path[i]]) {
                    $this.combined[k] = obj[path[i]];
                }
            });

            this.status.title            = this.checkLength('title', true);
            this.status['og.0.title']    = this.checkLength('og.0.title', true);
            this.status['twitter.title'] = this.checkLength('twitter.title', true);

            this.status.description            = this.checkLength('description');
            this.status['og.1.description']    = this.checkLength('og.1.description');
            this.status['twitter.description'] = this.checkLength('twitter.description');

            this.status.robots = this.checkVisibility();

        });

        this.$initBind = function() {
            this.root.$value = this.seo;
        };

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {
                value = {};
            }

            if (JSON.stringify(this.seo) != JSON.stringify(value)) {
                this.seo = value;
                this.update();
            }

        }.bind(this);

        this.on('bindingupdated', function() {

            Object.keys(this.config).forEach(function(k) {

                if ($this.config[k] != $this.defaultConfig[k]) {

                    if (!App.Utils.isObject($this.seo.config) || Array.isArray($this.seo.config)) {
                        $this.seo.config = {};
                    }

                    $this.seo.config[k] = $this.config[k];
                }
                else if ($this.config[k] == $this.defaultConfig[k]
                    && ($this.seo.config && typeof $this.seo.config[k] != 'undefined')
                    ) {
                    delete $this.seo.config[k];
                }

            });

            if (!this.seo.twitter) this.seo.twitter = {};
            this.seo.twitter = App.$.extend({}, this.twitter, {
                title: this.seo.twitter.title,
                description: this.seo.twitter.description
            });

            if (!this.seo.og) this.seo.og = [];
            this.seo.og = ([
                {title: this.seo.og[0] ? this.seo.og[0].title : ''},
                {description: this.seo.og[1] ? this.seo.og[1].description : ''}
            ]).concat(this.og);

            $this.$setValue(this.seo);
        });

        copyContent(e) {

            if (e) e.preventDefault();

            var source = e.target.dataset.source,
                target = e.target.dataset.target || source;

            // type check to copy single asset into gallery
            if (source == 'image' && this.$root.fieldsidx[this.fallback.image]
                && this.$root.fieldsidx[this.fallback.image].type == 'asset') {

                if (!this.seo.image || !Array.isArray(this.seo.image)) {
                    this.seo.image = [];
                }

                this.seo.image.push({
                    meta:{title: this.guess.image.title || '', asset: this.guess.image._id},
                    path: ASSETS_URL.replace(SITE_URL, '')+this.guess.image.path
                });
            }

            else if (source.indexOf('.') == -1 && target.indexOf('.') == -1) {
                this.seo[source] = this.guess[target];
            }

            else {

                // https://stackoverflow.com/a/6842900
                var obj = this.seo, path = target, i;
                path = path.split('.');
                for (i = 0; i < path.length - 1; i++) {
                    obj = obj[path[i]];
                }
                obj[path[i]] = this.guess[source];

            }

            $this.$setValue(this.seo);
        }

        checkLength(k, withBranding = false) {

            if ($this.combined[k] == undefined || typeof $this.combined[k] == 'undefined'
              || typeof $this.definitions[k] == 'undefined')  {
                return 0;
            }

            var d = $this.definitions[k], l = $this.combined[k].length;

            if (withBranding && this.config.addBranding) {
                l = ($this.combined[k] + $this.config.spacer + $this.config.branding).length;
            }

            return l < d.min || l > d.max ? 1
                   : ( l >= d.good_min && l <= d.good_max ? 10: 5 );

        }

        checkVisibility() {

            if (!this.seo.robots
              || !Array.isArray(this.seo.robots)
              || (Array.isArray(this.seo.robots) && !this.seo.robots.length)
              ) {
                return 10;
            }

            if (this.seo.robots.some(function(e) {
                return e == 'noindex' || e == 'none'
            })) {
                return 0;
            }

            if (this.seo.robots.some(function(e) {
                return e == 'noarchive' || e == 'nocache' || e == 'noimageindex' || e == 'nosnippet'
            })) {
                return 1;
            }

            return 5;
        }

        getRoot(node) {

            if (!node) node = this.root;

            if (node.hasOwnProperty('$boundTo')) {
                if (node.$boundTo.hasOwnProperty('collection') && node.$boundTo.hasOwnProperty('entry')) {
                    // to do: more checks - a parent could have entry property, too...
                    this.entryName = 'entry';
                    this.isCollection = true;
                    return node.$boundTo;
                }
                if (node.$boundTo.hasOwnProperty('singleton') && node.$boundTo.hasOwnProperty('data')) {
                    // to do: more checks - a parent could have data property, too...
                    this.entryName = 'data';
                    this.isSingleton = true;
                    return node.$boundTo;
                }
                if (node.$boundTo.hasOwnProperty('root')) {
                    return this.getRoot(node.$boundTo.root);
                }
            }
            return {};
        }

        truncate(str = '', length = 100) {
            return str.length <= length ? str :
                App.$.trim(str).substring(0, length).split(' ')
                    .slice(0, -1).join(' ') + '...';
        }

        // knowledge source: The SEO Framework WordPress plugin, GPL-3.0 License
        // https://github.com/sybrew/the-seo-framework
        // https://theseoframework.com/
        // https://github.com/sybrew/the-seo-framework/blob/master/inc/classes/admin-init.class.php#L228-L300
        this.definitions = {
            'title': {
                'min': 25,
                'good_min': 35,
                'good_max': 65,
                'max': 75,
            },
            'description': {
                'min': 45,
                'good_min': 80,
                'good_max': 160,
                'max': 320,
            },
            'og.0.title': {
                'min': 15,
                'good_min': 25,
                'good_max': 88,
                'max': 100,
            },
            'og.1.description': {
                'min': 45,
                'good_min': 80,
                'good_max': 200,
                'max': 300,
            },
            'twitter.title': {
                'min': 15,
                'good_min': 25,
                'good_max': 69,
                'max': 70,
            },
            'twitter.description': {
                'min': 45,
                'good_min': 80,
                'good_max': 200,
                'max': 200,
            },
        };

        // all, none, 
        // max-snippet:[number], max-video-preview:[number], max-image-preview:[setting], 
        // noimageindex, noarchive, nocache, notranslate, nosnippet, unavailable_after
        this.robotsOpts = {
            'placeholder': App.i18n.get('Add robots meta tag'),
            'autocomplete': [
                'noindex',
                'nofollow',
                'noimageindex',
                'noarchive',
                'nocache'
            ]
        };

        this.imageOpts = {
            title: {
                type: 'text',
                label: App.i18n.get('Alt text'),
                info: App.i18n.get('A description of what is in the image (not a caption).')
            }
        };

    </script>

</field-seo>

<cp-seo-field-sidebar>

    <style>
        .badge {
            display: inline-block;
            padding: 0px 4px;
            border: 1px solid rgba(0,0,0,.1);
            white-space: nowrap;
            vertical-align: middle;
            border-radius: 2px;
        }
        .uk-form-switch input[type="checkbox"] + label:before {
            box-shadow: 0 0 1px rgba(0,0,0,0.5);
        }
        .label-left .uk-form-switch input[type="checkbox"] + label {
            padding-left: 0;
            padding-right: 3.5em;
        }
        .label-left .uk-form-switch input[type="checkbox"] + label:before {
            left: auto;
            right: 0;
        }
        .label-left .uk-form-switch input[type="checkbox"] + label:after {
            left: auto;
            right: 1.75em;
        }
    </style>

    <cp-fieldcontainer class="seo-field-sidebar uk-margin uk-form uk-panel">

        <div class="uk-flex uk-flex-middle">
            <span class="uk-text-bold">{ App.i18n.get('SEO') }</span>
            <span class="uk-flex-item-1"></span>
            <span class="uk-text-small" show="{ $root && ($root.group == group || $root.group == '') }">
                <field-boolean class="label-left" bind="parent.advanced" label="{App.i18n.get('Advanced options')}"></field-boolean>
            </span>
        </div>

        <div class="uk-panel uk-margin-small">
            <div class="uk-flex">
                <div>
                    <span class="badge">
                        <span if="{!checksToggle}">T</span>
                        <span if="{checksToggle}">{ App.i18n.get('Title') }</span>
                        <cp-seo-field-score source="title"></cp-seo-field-score>
                    </span>

                    <span class="badge">
                        <span if="{!checksToggle}">D</span>
                        <span if="{checksToggle}">{ App.i18n.get('Description') }</span>
                        <cp-seo-field-score source="description"></cp-seo-field-score>
                    </span>

                    <span class="badge">
                        <span if="{!checksToggle}">V</span>
                        <span if="{checksToggle}">{ App.i18n.get('Visibility') }</span>
                        <span class="uk-icon-eye{ parent.status.robots >= 5 ? ' uk-text-success' : (parent.status.robots >= 1 ? '-slash uk-text-warning' : '-slash uk-text-danger') }" title="{ App.i18n.get('Score:') + ' ' + parent.status.robots }" data-uk-tooltip></span>
                    </span>

                    <span class="" show="{ $root && ($root.group == group || $root.group == '') }">
                        <span class="badge">
                            <span if="{!checksToggle}">oT</span>
                            <span if="{checksToggle}">{ App.i18n.get('OG Title') }</span>
                            <cp-seo-field-score source="og.0.title"></cp-seo-field-score>
                        </span>

                        <span class="badge">
                            <span if="{!checksToggle}">oD</span>
                            <span if="{checksToggle}">{ App.i18n.get('OG Description') }</span>
                            <cp-seo-field-score source="og.1.description"></cp-seo-field-score>
                        </span>

                        <span class="badge">
                            <span if="{!checksToggle}">tT</span>
                            <span if="{checksToggle}">{ App.i18n.get('Twitter Title') }</span>
                            <cp-seo-field-score source="twitter.title"></cp-seo-field-score>
                        </span>

                        <span class="badge">
                            <span if="{!checksToggle}">tD</span>
                            <span if="{checksToggle}">{ App.i18n.get('Twitter Description') }</span>
                            <cp-seo-field-score source="twitter.description"></cp-seo-field-score>
                        </span>
                    </span>
                </div>
                <div class="uk-flex-item-1"></div>
                <div class="">
                    <a href="#" class="uk-icon-chevron-circle-{ checksToggle ? 'left' : 'right' } uk-icon-hover uk-margin-small-left" onclick="{ toggleChecks }"></a>
                </div>
            </div>
        </div>

        <div class="uk-panel uk-margin">

            <div class="uk-flex uk-flex-middle uk-margin" show="{ $root && ($root.group == group || $root.group == '') }">
                <span class="uk-text-small">
                    <field-boolean bind="config.addBranding" label="{ App.i18n.get('Add branding') }"></field-boolean>
                </span>
                <span class="uk-flex-item-1"></span>
                <a href="#" class="uk-icon-chevron-circle-{ brandingToggle ? 'up' : 'down' } uk-icon-hover" onclick="{ toggleBranding }" if="{ config.addBranding }"></a>
            </div>

            <div class="uk-form" if="{ config.addBranding && brandingToggle }" show="{ $root && ($root.group == group || $root.group == '') }">

                <div class="uk-form-controls-condensed">
                    <label class="uk-text-middle">{ App.i18n.get('Spacer') }</label>
                    <input type="text" bind="config.spacer" class="uk-form-width-mini" />
                    <select bind="config.spacer" class="uk-form-width-mini">
                        <option value="{ config.spacer }">{config.spacer}</option>
                        <option each="{ o in spacerOpts }" value="{ o }">{ o }</option>
                    </select>
                </div>

                <div class="uk-form-controls-condensed">
                    <label class="uk-text-middle">{ App.i18n.get('Branding') }</label>
                    <input class="" type="text" bind="config.branding" />
                </div>

            </div>

        </div>

    </cp-fieldcontainer>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.config = {};
        this.$root = this.parent.$root;
        this.group = this.parent.group;

        this.brandingToggle = false;
        this.checksToggle   = false;

        this.on('mount', function() {

            this.config = this.root.$value;
            this.$root = this.parent.$root;
            this.group = this.parent.group;

            this.update();

        });

        this.on('bindingupdated', function() {
            $this.$setValue(this.config);
        });

        toggleBranding(e) {
            if (e) e.preventDefault();
            this.brandingToggle = !this.brandingToggle;
        }

        toggleChecks(e) {
            if (e) e.preventDefault();
            this.checksToggle = !this.checksToggle;
        }

        // | - &ndash; &mdash; &bull; &middot; &lsaquo; &rsaquo; &frasl; &laquo; &raquo; &lt; &gt;
        this.spacerOpts = [' | ', ' - ', ' – ', ' — ', ' • ', ' · ', ' ‹ ', ' › ', ' ⁄ ', ' « ', ' » ', ' < ', ' > '];

    </script>

</cp-seo-field-sidebar>


<cp-seo-field-guess>
    <div class="uk-block-muted uk-panel-card uk-border-rounded uk-margin-small-top" if="{ parent.fallback[opts.source] && parent.guess[opts.source] }">
        <div class="uk-flex uk-flex-middle">
            <span>
                { parent.guess[opts.source] }
                <span class="uk-text-muted" if="{ opts.withBranding && parent.config.addBranding }">{ parent.config.spacer.replace(/\s/g, '&nbsp;') + parent.config.branding }</span>
            </span>

            <span class="uk-flex-item-1"></span>

            <div class="uk-text-right">
                <i class="uk-icon uk-icon-question-circle uk-margin-small-left uk-text-muted" title="{ App.i18n.get('Source field:') } { parent.$root.fieldsidx[parent.fallback[opts.source]] && parent.$root.fieldsidx[parent.fallback[opts.source]].label || parent.fallback[opts.source] }" if="{ parent.fallback[opts.source] }" data-uk-tooltip></i>

                <span class="uk-text-muted uk-text-small uk-margin-small-left" title="{ opts.withBranding && parent.config.addBranding ? App.i18n.get('without branding:') + ' ' + parent.guess[opts.source].length : '' }" data-uk-tooltip>{ (parent.guess[opts.source] + (opts.withBranding && parent.config.addBranding ? parent.config.spacer + parent.config.branding: '')).length }</span>

                <a class="uk-icon-copy uk-icon-hover uk-margin-small-left" href="#" data-source="{opts.source}" data-target="{opts.target || opts.source}" onclick="{ parent.copyContent }" title="{ App.i18n.get('Copy content') }" data-uk-tooltip></a>
            </div>
        </div>
    </div>
</cp-seo-field-guess>


<cp-seo-field-score>
    <i class="uk-margin-small-left uk-icon-{ score < 2 ? 'frown-o uk-text-danger' : ( score < 5 ? 'meh-o uk-text-warning' : ( score < 10 ? 'smile-o uk-text-success' : 'heart-o uk-text-success' ) ) }" title="{ App.i18n.get('Score:') + ' ' + score }" data-uk-tooltip></i>

    <script>
        this.score = 0;
        this.on('mount', function() {
            this.update();
        });
        this.on('update', function() {
            this.score = this.parent.status ? this.parent.status[opts.source]
              : (this.parent.parent.status
                ? this.parent.parent.status[opts.source] : 0);
        });
    </script>
</cp-seo-field-score>


<cp-seo-field-length class="uk-text-muted uk-text-small uk-margin-right">
    <span
      if="{ parent.seo[opts.source] }"
      title="{ opts.withBranding && parent.config.addBranding ? App.i18n.get('without branding:') + ' ' + parent.seo[opts.source].length : '' }"
      data-uk-tooltip
    >
        { (parent.seo[opts.source] + (opts.withBranding && parent.config.addBranding ? parent.config.spacer + parent.config.branding : '')).length }
    </span>
</cp-seo-field-length>


App.Utils.renderer.seo = function(v, meta) {

    // to do...
    // title length, title branding, auto guess
    // description length, auto guess
    // robots index

    return 'SEO';

}
