/**
 * key-value-pair field for Cockpit CMS
 * 
 * @version 0.1.2
 * @author  Raffael Jesche
 * @license MIT
 * @see     https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-key-value-pair.tag
 * @see     https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-key-value-pair.md
 */

<field-key-value-pair>

    <style>
        .notice {
            background-color: aliceblue !important;
        }
        .middle {
            padding: 4px 0;
        }
    </style>

    <div if="{ wrongDataFormat }" class="uk-text-center uk-margin">
        <span class="uk-text-warning"><i class="uk-icon-warning uk-icon-small"></i> { App.i18n.get('Wrong data format') }</span>
        <a href="#" class="uk-button uk-button-primary" onclick="{ convertData }">{ App.i18n.get('Convert data') }</a>
    </div>

    <div ref="itemscontainer" class="uk-sortable">
        <div class="uk-panel uk-panel-box uk-panel-card uk-margin-small" data-idx="{ idx }" each="{ key,idx in keys }">

            <div class="uk-flex">

                <span class="uk-text-muted middle" if="{ dpfx }">{ dpfx }&nbsp;</span>
                <input class="uk-width-1-4 { duplicates.indexOf(idx) != -1 && (format == 'object' && 'uk-form-danger' || 'notice') }" type="text" bind="keys.{idx}" />
                <span class="uk-text-muted middle">&nbsp;:&nbsp;</span>
                <input class="uk-width-3-4" type="text" bind="values.{ idx }" />

                <span class="middle">
                    <a href="#" class="uk-icon-trash" data-idx="{ idx }" onclick="{ deletePair }" aria-label="{ App.i18n.get('Delete item') }"></a>
                </span>
            </div>

        </div>
    </div>
    <div class="uk-text-center uk-margin-small-top" if="{ !limit || limit > keys.length }">
        <a href="#" class="uk-margin-small-top uk-icon-plus uk-icon-small" onclick="{ newPair }" aria-label="{ App.i18n.get('Add item') }"></a>
    </div>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.keys = [];
        this.defaultKeys = [];
        this.values = [];
        this.duplicates = [];
        this.value = [];
        this.pfx = '';
        this.dpfx = '';
        this.format = '';
        this.limit = 0;
        this.wrongDataFormat = false;

        this.on('mount', function() {

            this.pfx    = opts.prefix || '';
            this.dpfx   = opts.displayPrefix || opts.prefix || '';
            this.format = opts.format || 'object';
            this.limit  = opts.limit  || false;
            this.defaultKeys = opts.defaultKeys || [];

            this.updateKeysValues();

            if (opts.sortable) {

                UIkit.sortable(this.refs.itemscontainer, {
                    animation: false
                }).on('stop.uk.sortable', function() {
                    $this.updateorder();
                });
            }
            
            if ( (this.value && this.format == 'array' && !Array.isArray(this.value))
              || (this.value && this.format == 'object' && Array.isArray(this.value) && this.value.length)
              ) {
                this.wrongDataFormat = true;
            }

            this.update();

        });

        this.$initBind = function() {
            this.root.$value = this.value;
        };

        this.$updateValue = function(value) {

            if (this.format == 'array' && !Array.isArray(value)) {
                value = [];
            }
            else if (this.format == 'object' && (!App.Utils.isObject(value) || Array.isArray(value))) {
                value = {};
            }

            if (JSON.stringify(this.value) != JSON.stringify(value)) {
                this.value = value;
            }

        }.bind(this);

        this.on('bindingupdated', function() {

            this.value = this.format == 'object' ? {} : [];
            this.duplicates = [];

            this.keys.forEach(function(k,i) {

                if ($this.format == 'array' && k.length) {
                    $this.value.push({[$this.pfx+k]:$this.values[i] || ''});
                }

                if ($this.format == 'object' && k.length) {
                    $this.value[$this.pfx+k] = $this.values[i] || '';
                }

                var index = $this.keys.indexOf(k);
                if (index !== i) {
                    $this.duplicates.push(i);
                    $this.duplicates.push(index);
                }
            });

            $this.$setValue(this.value);

        });

        updateKeysValues() {

            this.keys = [];
            this.values = [];

            if ( !this.value
              || (this.format == 'array' && Array.isArray(this.value) && !this.value.length)
              || (this.format == 'object' && !Object.keys(this.value).length)
                ) {
                this.keys = this.defaultKeys;
            }

            if (this.format == 'array' && Array.isArray(this.value) && this.value.length) {

                this.value.forEach(function(v,k) {

                    if (v === null) { // fix null values (edge case...?)
                        $this.value.splice(k,1);
                    }

                    else if (App.Utils.isObject(v)) {
                        $this.keys.push(Object.keys(v)[0]
                                      .replace(new RegExp('^'+$this.pfx), ''));
                        $this.values.push(Object.values(v)[0]);
                    }

                });

            }

            else if (this.format == 'object' && App.Utils.isObject(this.value)) {
                for (var k in this.value) {
                    this.keys.push(k.replace(new RegExp('^'+$this.pfx), ''));
                    this.values.push(this.value[k]);
                }
            }

        }

        newPair(e) {
            if (e) e.preventDefault();
            this.keys.push('');

            setTimeout(function() {
                App.$('[data-idx=' + ($this.keys.length - 1) + '] input:first-of-type', $this.root).get(0).focus();
            }, 50);
        }

        deletePair(e) {

            if (e) e.preventDefault();

            var idx = e.target.dataset.idx;

            if (this.opts && this.opts.safeDelete) {
                App.ui.confirm("Confirm removal?", function() {
                    $this.remove(idx);
                });
            }
            else {
                $this.remove(idx);
            }

        }

        remove(idx) {

            if (this.format == 'array' && (this.value[idx] !== undefined || this.value[idx] === null)) {
                this.value.splice(idx, 1);
            }
            if (this.format == 'object') {
                delete this.value[this.keys[$this.pfx+idx]];
            }

            if (this.keys[idx] !== undefined) {
                this.keys.splice(idx, 1);
            }
            if (this.values[idx] !== undefined) {
                this.values.splice(idx, 1);
            }

            this.trigger('bindingupdated');

            $this.$setValue(this.value);

        }

        updateorder() {

            var items = this.format == 'object' ? {} : [];

            App.$(this.refs.itemscontainer).children().each(function() {

                var idx = Number(this.getAttribute('data-idx'));

                if ($this.format == 'array') {
                    items.push({[$this.keys[idx]]:$this.values[idx] || ''});
                }
                if ($this.format == 'object') {
                    items[$this.keys[idx]] = $this.values[idx] || '';
                }

            });

            this.value = items;
            this.$setValue(items);

            this.keys = [];
            this.update();

            this.updateKeysValues();
            this.update();

        }

        convertData(e) {

            if (e) e.preventDefault();

            var value = this.format == 'array' ? [] : {};

            if (this.value && this.format == 'array' && !Array.isArray(this.value) && App.Utils.isObject(this.value)) {

                Object.keys(this.value).forEach(function(k) {
                    value.push({[k]:$this.value[k]});
                });
            }

            if (this.value && this.format == 'object' && Array.isArray(this.value) && this.value.length) {

                var value = {};
                this.value.forEach(function(v) {
                    var k = Object.keys(v)[0];
                    value[k] = v[k];
                });
            }

            this.value = value;
            this.wrongDataFormat = false;
            this.$setValue(this.value);
            this.updateKeysValues();
        }

    </script>

</field-key-value-pair>

App.Utils.renderer['key-value-pair'] = function(v, meta) {

    var warning = false;

    if (Array.isArray(v)) {
        v = v.map(function(e,i) {
            var k = Object.keys(e)[0];
            return k + ' : ' + v[i][k];
        });
        if (meta.options && meta.options.format == 'object') warning = true;
    }
    else if (App.Utils.isObject(v) && !Array.isArray(v)) {
        var vv = [];
        Object.keys(v).forEach(function(k) {
            vv.push(k + ' : ' + v[k]);
        });
        v = vv;
        if (meta.options && meta.options.format == 'array') warning = true;
    }
    else {
        return App.Utils.renderer.default(v);
    }

    if (!v.length) return '';

    warning = !warning ? '' : ' <span class="uk-badge uk-badge-danger" title="'+App.i18n.get('Wrong data format')+'" data-uk-tooltip>!</span>'

    return '<span class="uk-badge" title="'+v.join('<br>')+'" data-uk-tooltip>'+v.length+'</span>' + warning;
};
