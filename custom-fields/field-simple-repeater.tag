// version: 0.1.1
// usage: https://github.com/raffaelj/cockpit-scripts/tree/master/custom-fields/field-simple-repeater.md

App.Utils.renderer['simple-repeater'] = function(v) {

    if (typeof(v[0]) === 'string') {
        return App.Utils.renderer.tags(v);
    }

    if (typeof(v[0]) === 'object') {

        if (v.length > 5) {
            // don't render too much output
            return App.Utils.renderer.repeater(v);
        }

        var out = '';
        for (k in v) {
            var tags = [];
            for (val in v[k]) {
                if (typeof(v[k][val]) !== 'string') {
                    // don't render nested output
                    return App.Utils.renderer.repeater(v);
                }
                tags.push(v[k][val]);
            }
            out += App.Utils.renderer.tags(tags) + (k < v.length ? ' ' : '');
        }
        return out;
    }
};

<field-simple-repeater>

    <div class="uk-alert" show="{ !items.length }">
        { App.i18n.get('No items') }.
    </div>

    <div show="{mode=='edit' && items.length}" if="{ field }">

        <div class="uk-margin uk-panel-box uk-panel-card" each="{ item,idx in items }" data-idx="{idx}">
            <div class="uk-badge uk-display-block uk-margin">{ field ? App.Utils.ucfirst( field.label || field.type) : '' }</div>

            <cp-field type="{ field.type || 'text' }" bind="items[{ idx }]" opts="{ field.options || {} }"></cp-field>

            <div class="uk-panel-box-footer uk-bg-light">
                <a onclick="{ parent.remove }"><i class="uk-icon-trash-o"></i></a>
            </div>
        </div>
    </div>

    <div ref="itemscontainer" class="uk-sortable" show="{ mode=='reorder' && items.length }">
        <div class="uk-margin uk-panel-box uk-panel-card" each="{ item,idx in items }" data-idx="{idx}">
            <div class="uk-grid uk-grid-small">
                <div class="uk-flex-item-1"><i class="uk-icon-bars uk-margin-small-right"></i> { field ? App.Utils.ucfirst(field.label || field.type) : '' }</div>
                <div class="uk-text-muted uk-text-small uk-text-truncate"> <raw content="{ parent.getOrderPreview(item,idx) }"></raw></div>
            </div>
        </div>
    </div>

    <div class="uk-margin">
        <a class="uk-button" onclick="{ add }" show="{ mode=='edit' }"><i class="uk-icon-plus-circle"></i> { App.i18n.get('Add item') }</a>

        <a class="uk-button uk-button-success" onclick="{ updateorder }" show="{ mode=='reorder' }"><i class="uk-icon-check"></i> { App.i18n.get('Update order') }</a>
        <a class="uk-button uk-button-link uk-link-reset" onclick="{ switchreorder }" show="{ items.length > 1 }">
            <span show="{ mode=='edit' }"><i class="uk-icon-arrows"></i> { App.i18n.get('Reorder') }</span>
            <span show="{ mode=='reorder' }">{ App.i18n.get('Cancel') }</span>
        </a>
    </div>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.items  = [];
        this.field  = null;
        this.mode   = 'edit';

        this.on('mount', function() {

            UIkit.sortable(this.refs.itemscontainer, {
                animation: false
            });

            this.update();
        });

        this.on('update', function() {
            this.field  = opts.field || {type:'text'};
        })

        this.$initBind = function() {
            this.root.$value = this.items;
        };

        this.$updateValue = function(value) {

            if (!Array.isArray(value)) {
                value = [];
            }

            if (JSON.stringify(this.items) != JSON.stringify(value)) {
                this.items = value;
                this.update();
            }

        }.bind(this);

        this.on('bindingupdated', function() {
            $this.$setValue(this.items);
        });

        add(e) {

            if (opts.limit && this.items.length >= opts.limit) {
                App.ui.notify('Maximum amount of items reached');
                return;
            }

            if (this.field.type == 'set') {
                var item = {};
                this.field.options.fields.forEach(function(field) {
                    item[field.name] = null;
                });
                this.items.push(item);
            }
            else {
                this.items.push(null);
            }

        }

        remove(e) {
            this.items.splice(e.item.idx, 1);
        }

        switchreorder() {
            $this.mode = $this.mode == 'edit' ? 'reorder':'edit';
        }

        updateorder() {

            var items = [];

            App.$(this.refs.itemscontainer).children().each(function(){
                items.push($this.items[Number(this.getAttribute('data-idx'))]);
            });

            $this.items = [];
            $this.update();

            setTimeout(function() {
                $this.mode = 'edit';
                $this.items = items;
                $this.$setValue(items);

                setTimeout(function(){
                    $this.update();
                }, 50)
            }, 50);
        }

        getOrderPreview(item, idx) {

            if (this.field && this.field.type && item) {
                return App.Utils.renderValue(this.field.type, item, this.field);
            }

            return 'Item '+(idx+1);

        }

    </script>

</field-simple-repeater>
