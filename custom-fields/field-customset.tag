/**
 * This is a riot.js/Javascript file. Syntax highlighting in my text editor is a bit
 * weird, because of the mixed content, but it works. If you place this file
 * in `path/to/cockpit/config/tags`, it will be loaded automatically.
 * The name must start with "field-", so the field manager will detect it.
 * 
 * This custom field is a simple demo by Raffael Jesche. It is a 99% copy of
 * https://github.com/agentejo/cockpit/blob/next/modules/Cockpit/assets/components/field-set.tag
 */

// The default renderer in entries view has no clue about this new field.
// So you have to tell the app, how to display the values:

App.Utils.renderer['customset'] = function(v, meta) {
    
    // create a custom renderer
    // field options: {"custom":true}
    if (meta.options.custom) {
        return '<span>Yeah! ' + v.title + '</span>';
    }
    
    // or use default renderer for set field
    // field options: {"display":"{title} - {content}"}
    return App.Utils.renderer.set(v, meta);
}

<field-customset>

    <div>

        <div class="uk-margin" each="{field,idx in fields}">
            <label class="uk-display-block uk-text-bold uk-text-small">{ field.label || field.name || ''}</label>
            <cp-field class="uk-display-block uk-margin-small-top" type="{ field.type || 'text' }" bind="value.{field.name}" opts="{ field.options || {} }"></cp-field>
        </div>

    </div>

    <script>

        var $this = this;

        this._field = null;
        this.set    = {};
        this.value  = {};
        this.fields = [];
        
        var myFields = [
            {
                'type': 'text',
                'name': 'title',
                'label': 'Title'
            },
            {
                'type': 'textarea',
                'name': 'content',
                'label': 'Content'
            },
            {
                'type': 'collectionlink',
                'name': 'linked_item',
                'label': 'Linked Item',
                'options': {
                    'link': 'pages',
                    'display': 'title'
                }
            }
        ];

        riot.util.bind(this);

        this.on('mount', function() {
            this.update();
        });

        this.on('update', function() {
            this.fields = myFields;
        });

        this.$initBind = function() {
            this.root.$value = this.value;
        };

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {

                value = {};

                this.fields.forEach(function(field){
                    value[field.name] = null;
                });
            }

            if (JSON.stringify(this.value) != JSON.stringify(value)) {
                this.value = value;
                this.update();
            }

            this._field = field;

        }.bind(this);

        this.on('bindingupdated', function() {
            $this.$setValue(this.value);
        });

    </script>

</field-customset>
