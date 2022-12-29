/**
 * SEO field for Cockpit CMS v1
 *
 * This field requires the `key-value-field`. It is shipped with the
 * CpMultiplaneGUI addon, but if you came from the `cockpit-scripts`
 * repository, make sure to copy that field, too.
 *
 * Usage is described in the corresponding `<field-name>.md` files.
 *
 * @version 0.2.0
 * @author  Raffael Jesche
 * @license MIT
 *
 * @see     https://github.com/raffaelj/cockpit_CpMultiplaneGUI/blob/master/assets/components
 * @see     https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields
 */

<field-seo>

    <style>
        .uk-block-muted {
            background-color: rgba(0,0,0,.01);
            padding: .5em;
        }
    </style>

    <div>

        <cp-seo-field-sidebar></cp-seo-field-sidebar>

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
                        <span class="uk-text-muted uk-text-nowrap" if="{ !hideBranding }">{ spacer.replace(/\s/g, '&nbsp;') + branding }</span>
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

            <div class="uk-width-1-1" if="{ !hide.config }">

                <cp-seo-field-config bind="seo.config"></cp-seo-field-config>

            </div>

            <div class="uk-width-medium-1-{ hide.twitter ? '1' : '2' }" if="{ advanced && !hide.og }">

                <cp-seo-field-og bind="seo.og"></cp-seo-field-og>

            </div>

            <div class="uk-width-medium-1-{ hide.og ? '1' : '2' }" if="{ advanced && !hide.twitter }">

                <cp-seo-field-twitter bind="seo.twitter"></cp-seo-field-twitter>

            </div>

            <div class="uk-width-medium-1-2" if="{ advanced && !hide.robots }">
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

        this.seo      = {};

        this.guess    = {};
        this.combined = {};
        this.status   = {};
        this.fallback = {};

        this.lang     = '';
        this.localize = {title: false, description: false, image: false};

        this.advanced = false;
        this.hide     = {};

        this.hideBranding = false;
        this.spacer       = ' - ';
        this.branding     = '';

        var brandingOpts = {};
        this.appName      = document.querySelector('.app-name').innerText || '';
        this.defaults     = {};

        this.$root        = null;
        this.entryName    = ''; // collection: 'entry', singleton: 'data'
        this.isCollection = false;
        this.isSingleton  = false;

        this.on('mount', function() {

            // check, if in Collection or in Singleton for targeting
            // fallback values and current tab
            this.$root = this.getRoot();

// set tab to "SEO" while debugging
// this.$root.group = 'SEO';
// if (this.isSingleton) setTimeout(() => $this.$root.update(),0);

            this.lang = this.$root.lang;
            this.langSuffix = this.lang ? '_' + this.lang : '';

            this.advanced  = opts.advanced  || false;
            this.hide      = opts.hide      || {};
            this.fallback  = opts.fallback  || {};

            this.fallback['og.0.title']       = this.fallback['twitter.title']       = 'seo.title';
            this.fallback['og.1.description'] = this.fallback['twitter.description'] = 'seo.description';

            this.assignBranding();

            this.group = this.$root.fieldsidx && this.$root.fieldsidx.seo
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

            // move seo overview to entry sidebar
            if (sidebar) {
                var mp_sidebar = App.$('#multiplane_sidebar').get(0);
                if (mp_sidebar) App.$('cp-seo-field-sidebar').appendTo(mp_sidebar);
                else App.$('cp-seo-field-sidebar').prependTo(sidebar);
                delete mp_sidebar;
            }
            delete sidebar;

            // move field info from bottom to top (below label)
            var fieldInfo = this.root.closest('cp-fieldcontainer').querySelector(':scope > div:last-child.uk-text-small.uk-text-muted');
            if (fieldInfo) {
                var fieldLabel = this.root.closest('cp-fieldcontainer').querySelector(':scope > label:first-child');
                if (fieldLabel) fieldLabel.after(fieldInfo);
                delete fieldLabel;
            }
            delete fieldInfo;

            // remove parent field container (experimental)
            if (opts.container === false) {
                var container = App.$(this.root).closest('cp-fieldcontainer').get(0);
                if (container) {
                    App.$(container.parentNode).append(container.children);
                    container.parentNode.removeChild(container);
                }
                delete container;
            }

            // overwrite branding opts with data from request
            if (opts.optsFromRequest) {
                App.request(opts.optsFromRequest).then(function(data) {

                    brandingOpts = data;
                    if (!brandingOpts.spacer) brandingOpts.spacer = opts.spacer || ' - ';
                    $this.update();

                    // TODO:
                    // if (!brandingOpts.hasOwnProperty('hideBranding')) {
                    //     brandingOpts.hideBranding = opts.hideBranding || false;
                    // }

                }).catch(function(e) {
                    console.log(e);
                    brandingOpts = opts;
                });
            } else {
                brandingOpts = opts;
            }

        });

        this.on('update', function() {

            if (this.seo.twitter && Array.isArray(this.seo.twitter)) {
                this.seo.twitter = {};
            }

            if (this.seo.config && Array.isArray(this.seo.config)) {
                this.seo.config = {};
            }

            this.lang = this.$root.lang;
            this.langSuffix = this.lang ? '_' + this.lang : '';

            this.assignBranding();

            if (this.fallback.title) {
                var name = this.fallback.title;
                if (this.lang && this.localize.title) name += this.langSuffix;
                this.guess.title = this.$root[this.entryName][name];
            }

            if (this.fallback.description) {
                var name = this.fallback.description;
                if (this.lang && this.localize.description) name += this.langSuffix;
                this.guess.description = this.truncate(this.stripTags(
                                         this.$root[this.entryName][name]), 400);
            }

            if (this.fallback.image) {
                var name = this.fallback.image;
                if (this.lang && this.localize.image) name += this.langSuffix;
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

                    if (obj && obj.hasOwnProperty(path[i])) {
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

            $this.$setValue(this.seo);

        });

        assignBranding() {

            // TODO: brandingOpts.hideBranding

            this.defaults = {
                // hideBranding: brandingOpts['hideBranding'+this.langSuffix]
                                // || brandingOpts.hideBranding || false,
                hideBranding: opts.hideBranding || false,
                spacer:       brandingOpts['spacer'+this.langSuffix]
                                || brandingOpts.spacer || ' - ',
                branding:     brandingOpts['branding'+this.langSuffix]
                                || brandingOpts.branding || this.appName
            };

            Object.assign(this, this.defaults, this.seo.config || {});

        }

        isIntForArrayKeys(str) {
            return /^(0|[1-9]\d*)$/.test(str);
        }

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

                // inspired by https://stackoverflow.com/a/6842900
                var obj = this.seo, path = target, i;
                path = path.split('.');
                for (i = 0; i < path.length - 1; i++) {

                    if (!obj.hasOwnProperty(path[i])) {
                        if (path[i+1] && this.isIntForArrayKeys(path[i+1])) {
                            obj[path[i]] = [];
                        } else {
                            obj[path[i]] = {};
                        }
                    }
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

            if (withBranding && !this.hideBranding) {
                l = ($this.combined[k] + $this.spacer + $this.branding).length;
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

        stripTags(str) {

            if (typeof str != 'string' && Array.isArray(str)) {
                // content may be a repeater, try to use the first field
                if (str[0] && str[0].value && typeof str[0].value == 'string') {
                    str = str[0].value;
                }

                else {
                    str = '';
                }
            }

            return App.Utils.stripTags(str);

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
        .uk-button-text {
            font-size: inherit;
            min-height: auto;
            padding: 0;
        }
    </style>

    <cp-fieldcontainer class="seo-field-sidebar uk-margin uk-form uk-panel">

        <div class="">
            <span class="uk-text-bold">{ App.i18n.get('SEO') }</span>
        </div>

        <div class="uk-panel uk-margin-small">
            <div class="uk-flex">
                <div>
                    <span class="badge" if="{ !parent.hide.title }">
                        <span if="{!checksToggle}">{ App.i18n.get('Title').substr(0,1) }</span>
                        <span if="{checksToggle}">{ App.i18n.get('Title') }</span>
                        <cp-seo-field-score source="title"></cp-seo-field-score>
                    </span>

                    <span class="badge" if="{ !parent.hide.description }">
                        <span if="{!checksToggle}">{ App.i18n.get('Description').substr(0,1) }</span>
                        <span if="{checksToggle}">{ App.i18n.get('Description') }</span>
                        <cp-seo-field-score source="description"></cp-seo-field-score>
                    </span>

                    <span class="badge">
                        <span if="{!checksToggle}">{ App.i18n.get('Visibility').substr(0,1) }</span>
                        <span if="{checksToggle}">{ App.i18n.get('Visibility') }</span>
                        <span class="uk-icon-eye{ parent.status.robots >= 5 ? ' uk-text-success' : (parent.status.robots >= 1 ? '-slash uk-text-warning' : '-slash uk-text-danger') }" title="{ App.i18n.get('Score:') + ' ' + parent.status.robots }" data-uk-tooltip></span>
                    </span>

                    <span class="" show="{ parent.advanced && $root && ($root.group == group || $root.group == '') }">

                        <span class="badge" if="{ !parent.hide.og }">
                            <span if="{!checksToggle}">o{ App.i18n.get('Title').substr(0,1) }</span>
                            <span if="{checksToggle}">OG { App.i18n.get('Title') }</span>
                            <cp-seo-field-score source="og.0.title"></cp-seo-field-score>
                        </span>

                        <span class="badge" if="{ !parent.hide.og }">
                            <span if="{!checksToggle}">o{ App.i18n.get('Description').substr(0,1) }</span>
                            <span if="{checksToggle}">OG { App.i18n.get('Description') }</span>
                            <cp-seo-field-score source="og.1.description"></cp-seo-field-score>
                        </span>

                        <span class="badge" if="{ !parent.hide.twitter }">
                            <span if="{!checksToggle}">t{ App.i18n.get('Title').substr(0,1) }</span>
                            <span if="{checksToggle}">Twitter { App.i18n.get('Title') }</span>
                            <cp-seo-field-score source="twitter.title"></cp-seo-field-score>
                        </span>

                        <span class="badge" if="{ !parent.hide.twitter }">
                            <span if="{!checksToggle}">t{ App.i18n.get('Description').substr(0,1) }</span>
                            <span if="{checksToggle}">Twitter { App.i18n.get('Description') }</span>
                            <cp-seo-field-score source="twitter.description"></cp-seo-field-score>
                        </span>
                    </span>
                </div>
                <div class="uk-flex-item-1"></div>
                <div class="">
                    <button type="button" class="uk-button uk-button-link uk-button-text uk-icon-chevron-circle-{ checksToggle ? 'left' : 'right' } uk-icon-hover uk-margin-small-left" onclick="{ toggleChecks }" aria-label="{ App.i18n.get('Expand/Hide') }"></button>
                </div>
            </div>
        </div>

    </cp-fieldcontainer>

    <script>

        this.checksToggle   = false;

        this.on('mount', function() {
            this.$root = this.parent.$root;
            this.group = this.parent.group;
        });

        toggleChecks(e) {
            if (e) e.preventDefault();
            this.checksToggle = !this.checksToggle;
        }

    </script>

</cp-seo-field-sidebar>










<cp-seo-field-config>

    <label class="uk-text-bold">
        { App.i18n.get('Config') }
    </label>

    <div class="uk-panel uk-margin">
        <cp-fieldcontainer>

            <div class="uk-grid uk-grid-match uk-grid-width-medium-1-2 uk-grid-width-xlarge-1-4" data-uk-grid-margin>

                <div>
                    <div class="uk-flex uk-flex-middle">
                    <field-boolean bind="parent.advanced" label="{ App.i18n.get('Show advanced options') }"></field-boolean>
                </div>
                </div>

                <div>
                    <div class="uk-flex uk-flex-middle">
                    <field-boolean ref="hideBranding" bind="config.hideBranding" label="{ App.i18n.get('Hide branding') }"></field-boolean>
                </div>
                </div>

                <div>
                    <div class="uk-flex uk-flex-middle uk-flex-wrap">
                        <label class="uk-margin-small-right">{ App.i18n.get('Custom spacer') }</label>
                        <input type="text" bind="config.spacer" class="uk-form-width-mini uk-margin-small-right" placeholder="{ parent.defaults.spacer }" />
                        <select bind="config.spacer" class="uk-form-width-mini">
                            <option value="{ config.spacer || parent.defaults.spacer }">{ config.spacer || parent.defaults.spacer }</option>
                            <option each="{ o in spacerOpts }" value="{ o }">{ o }</option>
                        </select>
                    </div>
                </div>

                <div>
                    <div class="uk-flex uk-flex-middle uk-flex-wrap">
                        <label class="uk-margin-small-right">{ App.i18n.get('Custom branding') }</label>
                        <input class="" type="text" bind="config.branding" placeholder="{ parent.defaults.branding }" />
                    </div>
                </div>
            </div>
        </cp-fieldcontainer>

    </div>

    <script>

        var $this = this;
        riot.util.bind(this);

        this.config = {};

        this.$initBind = function() {
            this.root.$value = this.config;
        };

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {
                value = {};
            }

            if (JSON.stringify(this.config) != JSON.stringify(value)) {
                this.config = value;
                this.update();

                // Take care of hideBranding boolean field after toggling
                // language, because there is a missing update for non-boolean
                // initial values
                if (!this.config.hasOwnProperty('hideBranding')) {
                    this.refs.hideBranding.refs.check.checked = false;
                }
            }

        }.bind(this);

        this.on('mount', function() {

            this.$root = this.parent.$root;
            this.group = this.parent.group;

        });

        this.on('bindingupdated', function() {

            $this.$setValue(this.config);

        });

        this.on('update', function() {

            if (!this.config) this.config = {};

            // keep config keys clean if they match defaults
            Object.keys(this.config).forEach(k => {
                if (this.config[k] === this.parent.defaults[k]) delete this.config[k];
            });

            // delete if whitespace
            if (!this.config.branding || !this.config.branding.trim()) delete this.config.branding;

        });

        // | - &ndash; &mdash; &bull; &middot; &lsaquo; &rsaquo; &frasl; &laquo; &raquo; &lt; &gt;
        this.spacerOpts = [' | ', ' - ', ' – ', ' — ', ' • ', ' · ', ' ‹ ', ' › ', ' ⁄ ', ' « ', ' » ', ' < ', ' > '];

    </script>

</cp-seo-field-config>










<cp-seo-field-guess>

    <div class="uk-block-muted uk-panel-card uk-border-rounded uk-margin-small-top" if="{ _parent && _parent.fallback[opts.source] && _parent.guess[opts.source] }">
        <div class="uk-flex uk-flex-middle">
            <span>
                { _parent.guess[opts.source] }
                <span class="uk-text-muted" if="{ opts.withBranding && !_parent.hideBranding }">{ _parent.spacer.replace(/\s/g, '&nbsp;') + _parent.branding }</span>
            </span>

            <span class="uk-flex-item-1"></span>

            <div class="uk-text-right">
                <i class="uk-icon uk-icon-question-circle uk-margin-small-left uk-text-muted" title="{ App.i18n.get('Source field:') } { _parent.$root.fieldsidx[_parent.fallback[opts.source]] && _parent.$root.fieldsidx[_parent.fallback[opts.source]].label || _parent.fallback[opts.source] }" if="{ _parent.fallback[opts.source] }" data-uk-tooltip></i>

                <span class="uk-text-muted uk-text-small uk-margin-small-left" title="{ opts.withBranding && !_parent.hideBranding ? App.i18n.get('without branding:') + ' ' + _parent.guess[opts.source].length : '' }" data-uk-tooltip>{ (_parent.guess[opts.source] + (opts.withBranding && !_parent.hideBranding ? _parent.spacer + _parent.branding: '')).length }</span>

                <a class="uk-icon-copy uk-icon-hover uk-margin-small-left" href="#" data-source="{opts.source}" data-target="{opts.target || opts.source}" onclick="{ _parent.copyContent }" title="{ App.i18n.get('Copy content') }" data-uk-tooltip></a>
            </div>
        </div>
    </div>

    <script>

        this.on('mount', function() {
            this._parent = opts.parent || this.parent;
        });

    </script>

</cp-seo-field-guess>










<cp-seo-field-score>

    <i class="uk-margin-small-left uk-icon-{ score < 2 ? 'frown-o uk-text-danger' : ( score < 5 ? 'meh-o uk-text-warning' : ( score < 10 ? 'smile-o uk-text-success' : 'heart-o uk-text-success' ) ) }" title="{ App.i18n.get('Score:') + ' ' + score }" data-uk-tooltip></i>

    <script>

        this.score = 0;

        this.on('mount', function() {

            this._parent = opts.parent || this.parent;
            this.update();

        });

        this.on('update', function() {
            if (!this._parent) return;
            this.score = this._parent.status ? this._parent.status[opts.source]
              : (this._parent.parent.status
                ? this._parent.parent.status[opts.source] : 0);
        });

    </script>

</cp-seo-field-score>










<cp-seo-field-length class="uk-text-muted uk-text-small uk-margin-right">

    <span
      if="{ parent.seo[opts.source] }"
      title="{ opts.withBranding && !parent.hideBranding ? App.i18n.get('without branding:') + ' ' + parent.seo[opts.source].length : '' }"
      data-uk-tooltip
    >
        { (parent.seo[opts.source] + (opts.withBranding && !parent.hideBranding ? parent.spacer + parent.branding : '')).length }
    </span>

</cp-seo-field-length>










<cp-seo-field-twitter>

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

                <span class="uk-text-muted uk-text-small uk-margin-right" if="{ twitter && twitter.title }">{ (twitter.title + (!hideBranding ? spacer + branding: '')).length }</span>

                <cp-seo-field-score parent="{ parent }" source="twitter.title"></cp-seo-field-score>
            </div>

                <div class="uk-flex uk-flex-middle">
                <input class="uk-width-1-1" type="text" bind="twitter.title" />
                <span class="uk-text-muted uk-text-nowrap" if="{ !hideBranding }">{ spacer.replace(/\s/g, '&nbsp;') + branding }</span>
            </div>

            <div class="uk-margin-top uk-text-small uk-text-muted">
                { App.i18n.get('min: 15, good: 25-69, max: 70') }
            </div>
            <cp-seo-field-guess parent="{ parent }" source="twitter.title" target="twitter.title" with-branding="1"></cp-seo-field-guess>
        </cp-fieldcontainer>
    </div>

    <div class="uk-width-1-1 uk-margin-top">
        <cp-fieldcontainer>
            <div class="uk-flex uk-flex-middle">
                <label class="uk-text-bold">
                    twitter:description
                </label>

                <span class="uk-flex-item-1"></span>

                <span class="uk-text-muted uk-text-small uk-margin-right" if="{ twitter && twitter.description }">{ twitter.description.length }</span>

                <cp-seo-field-score parent="{ parent }" source="twitter.description"></cp-seo-field-score>
            </div>

            <div class="uk-margin-top">
                <textarea rows="4" class="uk-width-1-1" bind="twitter.description" bind-event="input"></textarea>
            </div>

            <div class="uk-margin-top uk-text-small uk-text-muted">
                { App.i18n.get('min: 45, good: 80-200, max: 200') }
            </div>
            <cp-seo-field-guess parent="{ parent }" source="twitter.description" target="twitter.description"></cp-seo-field-guess>
        </cp-fieldcontainer>
    </div>

    <div class="uk-width-1-1 uk-margin-top">
        <cp-fieldcontainer>
            <label class="uk-text-bold">
                { App.i18n.get('Custom Twitter meta tags') }
            </label>
            <div class="uk-margin-top">
                <field-key-value-pair bind="extraTags" display-prefix="twitter:"></field-key-value-pair>
            </div>
        </cp-fieldcontainer>
    </div>

    <script>

        // TODO: hide.twitter.title etc.

        var $this = this;
        riot.util.bind(this);

        this.spacer       = this.parent.spacer;
        this.branding     = this.parent.branding;
        this.hideBranding = this.parent.hideBranding;

        this.twitter      = {};
        this.extraTags    = {};

        this.$initBind = function() {
            this.root.$value = this.twitter;
        };

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {
                value = {};
            }

            if (JSON.stringify(this.twitter) != JSON.stringify(value)) {
                this.twitter = value;
                this.extraTags = this.extractExtraTags();
                this.update();
            }

        }.bind(this);

        this.on('update', function() {

            this.spacer       = this.parent.spacer;
            this.branding     = this.parent.branding;
            this.hideBranding = this.parent.hideBranding;

            // clean empty values
            ['title', 'description'].forEach(k => {
                if (this.twitter.hasOwnProperty(k)
                    && (typeof this.twitter[k] != 'string'
                        || !this.twitter[k].trim())) {
                    delete this.twitter[k];
                }
            });

        });

        this.on('bindingupdated', function() {

            // merge custom tags
            if (this.extraTags) {
                this.twitter = {
                    title:       this.twitter.title,
                    description: this.twitter.description,
                    ...this.extraTags
                };
            }

            $this.$setValue(this.twitter);

        });

        extractExtraTags() {
            return Object.fromEntries(
                Object.entries(this.twitter || {}).filter(([k, v]) => {
                    return !['title', 'description'].includes(k);
                }));
        }

    </script>

</cp-seo-field-twitter>










<cp-seo-field-og>

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

                <span class="uk-text-muted uk-text-small uk-margin-right" if="{ og && og[0] && og[0].title }">{ (og[0].title + (!hideBranding ? spacer + branding: '')).length }</span>

                <cp-seo-field-score parent="{ parent }" source="og.0.title"></cp-seo-field-score>
            </div>

                <div class="uk-flex uk-flex-middle">
                <input class="uk-width-1-1" type="text" bind="og.0.title" />
                <span class="uk-text-muted uk-text-nowrap" if="{ !hideBranding }">{ spacer.replace(/\s/g, '&nbsp;') + branding }</span>
            </div>
            <div class="uk-margin-top uk-text-small uk-text-muted">
                { App.i18n.get('min: 15, good: 25-88, max: 100') }
            </div>
            <cp-seo-field-guess parent="{ parent }" source="og.0.title" target="og.0.title" with-branding="1"></cp-seo-field-guess>
        </cp-fieldcontainer>
    </div>

    <div class="uk-width-1-1 uk-margin-top">
        <cp-fieldcontainer>
            <div class="uk-flex uk-flex-middle">
                <label class="uk-text-bold">
                    og:description
                </label>

                <span class="uk-flex-item-1"></span>

                <span class="uk-text-muted uk-text-small uk-margin-right" if="{ og && og[1] && og[1].description }">{ og[1].description.length }</span>

                <cp-seo-field-score parent="{ parent }" source="og.1.description"></cp-seo-field-score>
            </div>

            <div class="uk-margin-top">
                <textarea rows="4" class="uk-width-1-1" bind="og.1.description" bind-event="input"></textarea>
            </div>
            <div class="uk-margin-top uk-text-small uk-text-muted">
                { App.i18n.get('min: 45, good: 80-200, max: 300') }
            </div>
            <cp-seo-field-guess parent="{ parent }" source="og.1.description" target="og.1.description"></cp-seo-field-guess>
        </cp-fieldcontainer>
    </div>

    <div class="uk-width-1-1 uk-margin-top">
        <cp-fieldcontainer>
            <label class="uk-text-bold">
                { App.i18n.get('Custom Open Graph meta tags') }
            </label>
            <div class="uk-margin-top">
                <field-key-value-pair bind="extraTags" format="array" display-prefix="og:"></field-key-value-pair>
            </div>
        </cp-fieldcontainer>
    </div>

    <script>

        var $this = this;
        riot.util.bind(this);

        this.spacer       = this.parent.spacer;
        this.branding     = this.parent.branding;
        this.hideBranding = this.parent.hideBranding;

        this.og           = [];
        this.extraTags    = [];

        this.$initBind = function() {
            this.root.$value = this.og;
        };

        this.$updateValue = function(value, field) {

            if (!Array.isArray(value)) {
                value = [];
            }

            if (JSON.stringify(this.og) != JSON.stringify(value)) {
                this.og = value;

                this.extraTags = this.extractExtraTags();
                this.update();
            }

        }.bind(this);

        this.on('update', function() {

            this.spacer       = this.parent.spacer;
            this.branding     = this.parent.branding;
            this.hideBranding = this.parent.hideBranding;

            // TODO: clean empty values

        });

        this.on('bindingupdated', function() {

            // merge custom tags
            if (this.extraTags) {
                this.og = ([
                    {title:       this.og[0] ? this.og[0].title       : ''},
                    {description: this.og[1] ? this.og[1].description : ''}
                ]).concat(this.extraTags);

            }

            $this.$setValue(this.og);

        });

        extractExtraTags() {

            return this.og.filter(v => {
                return !(v.hasOwnProperty('title') || v.hasOwnProperty('description'));
            });

        }

    </script>

</cp-seo-field-og>










App.Utils.renderer.seo = function(v, meta) {

    // to do...
    // title length, title branding, auto guess
    // description length, auto guess
    // robots index

    return 'SEO';

}
