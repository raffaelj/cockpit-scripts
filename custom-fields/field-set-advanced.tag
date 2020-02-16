/**
 * copy/paste from core field-set.tag, but with a field container representation
 * and customizable widths of child fields
 * 
 * @version 0.1.0
 * @author  Raffael Jesche
 * @license MIT
 * @see     https://github.com/raffaelj/cockpit-scripts/blob/master/custom-fields/field-set-advanced.tag
 */

App.Utils.renderer['set-advanced'] = function(v, meta) {return App.Utils.renderer.set(v, meta);};

<field-set-advanced>

    <div>
        <div class="uk-grid uk-grid-match uk-grid-gutter">
            <div class="uk-width-medium-{field.width || 1}" each="{field,idx in fields}">

                <cp-fieldcontainer>

                    <label title="{ field.name }">

                        <span class="uk-text-bold"><i class="uk-icon-pencil-square uk-margin-small-right"></i> { field.label || App.Utils.ucfirst(field.name) }</span>

                    </label>

                    <div class="uk-margin-top">
                        <cp-field type="{ field.type || 'text' }" bind="value.{field.name}" opts="{ field.options || {} }"></cp-field>
                    </div>

                    <div class="uk-margin-top uk-text-small uk-text-muted" if="{field.info}">
                        { field.info || ' ' }
                    </div>

                </cp-fieldcontainer>

            </div>
        </div>

    </div>

    <script>

        var $this = this;

        this._field = null;
        this.set    = {};
        this.value  = {};
        this.fields = [];

        riot.util.bind(this);

        this.on('mount', function() {
            this.fields = opts.fields || [];
            this.update();
        });

        this.on('update', function() {
            this.fields = opts.fields || [];
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

</field-set-advanced>
