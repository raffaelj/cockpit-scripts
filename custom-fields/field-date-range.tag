// version: 0.1.0
// usage: to do...

App.Utils.renderer['date-range'] = function(v) {

    if (!v.from || !v.from.date) return '';
    
    if (v.from.date && !v.to.date || v.from.date == v.to.date) {
        if (v.from.time && v.to.time)
            return v.from.date + ' (' + v.from.time + ' - ' + v.to.time + ')';
        else if (v.from.time)
            return v.from.date + ' (' + v.from.time + ')';
        else if (v.to.time)
            return v.from.date + ' (' + v.to.time + ')';
        else return v.from.date
    }

    return v.from.date + (v.from.time ? ' (' + v.from.time + ')' : '') + (v.to.date ? ' - ' + v.to.date : '') + (v.to.time ? ' (' + v.to.time + ')' : '');

};

<field-date-range>

    <style>
        .uk-autocomplete
        ,label
        {
            display:block;
        }
    </style>

    <div class="uk-grid uk-grid-match uk-grid-gutter">

        <div class="uk-width-medium-1-2 uk-grid uk-grid-match">

            <label><span class="uk-text-bold">{ App.i18n.get('From') }</span></label>

                <div class="uk-width-medium-1-1 uk-margin-small">
                    <div class="uk-width-medium-1-4">
                        <label><i class="uk-icon-calendar"></i> <span class="uk-text-bold">{ App.i18n.get('Date') }</span></label>
                    </div>
                    <div class="uk-width-medium-3-4">
                        <field-date bind="value.from.date"></field-date>
                    </div>
                </div>
                <div class="uk-width-medium-1-1 uk-margin-small">
                    <div class="uk-width-medium-1-4">
                        <label><i class="uk-icon-clock-o"></i> <span class="uk-text-bold">{ App.i18n.get('Time') }</span></label>
                    </div>
                    <div class="uk-width-medium-3-4">
                        <field-time bind="value.from.time"></field-time>
                    </div>
                </div>

        </div>

        <div class="uk-width-medium-1-2 uk-grid uk-grid-match">

            <label><span class="uk-text-bold">{ App.i18n.get('To') }</span></label>

                <div class="uk-width-medium-1-1 uk-margin-small">
                    <div class="uk-width-medium-1-4">
                        <label><i class="uk-icon-calendar"></i> <span class="uk-text-bold">{ App.i18n.get('Date') }</span></label>
                    </div>
                    <div class="uk-width-medium-3-4">
                        <field-date bind="value.to.date"></field-date>
                    </div>
                </div>
                <div class="uk-width-medium-1-1 uk-margin-small">
                    <div class="uk-width-medium-1-4">
                        <label><i class="uk-icon-clock-o"></i> <span class="uk-text-bold">{ App.i18n.get('Time') }</span></label>
                    </div>
                    <div class="uk-width-medium-3-4">
                        <field-time bind="value.to.time"></field-time>
                    </div>
                </div>

        </div>

    </div>

    <script>

        var $this = this;

        this.value = {};

        riot.util.bind(this);

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {
                value = {"from":{"date":null,"time":null},"to":{"date":null,"time":null}};
            }

            if (JSON.stringify(this.value) != JSON.stringify(value)) {
                this.value = value;
                this.update();
            }

        }.bind(this);

        this.on('bindingupdated', function() {
            $this.$setValue(this.value);
        });

    </script>

</field-date-range>
