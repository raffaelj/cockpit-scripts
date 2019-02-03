# Custom renderers

Sometimes the field content renderer in entries view doesn't show the content in the preferred way.

## Example for set field

To see the full functionality, use the next branch >= [this commit][1] (2018-11-07). Before this update, field definitions weren't passed to the renderer. For older versions, there is a fallback to display a simple items counter instead. Have a look at [the discussion on discourse][2] for some more background. Scroll down for screenshots.

If you want to write your own renderers, have a look at [app.utils.js][3] and discover the core renderers `App.Utils.renderer.{fieldname}`. You can overwrite everything, you want with a custom js file.

[1]: https://github.com/agentejo/cockpit/commit/907c1de5ba92f7bbab25635ad20d8b1d5d43a099
[2]: https://discourse.getcockpit.com/t/renderer-for-set-field-in-backend/372
[3]: https://github.com/agentejo/cockpit/blob/next/assets/app/js/app.utils.js


**bootstrap.php**

```php
if (COCKPIT_ADMIN && !COCKPIT_API_REQUEST) {

    $app->on('admin.init', function(){

        $this->helper('admin')->addAssets('path/to/custom.js');
        $this->helper('admin')->addAssets('path/to/custom.css');

    });

}
```

**custom.js**

```js
App.Utils.renderer.set = function(v, field = null) {

    var out = '';

    if (field) {
        field.options.fields.map(function(e){

            if (e.display) {

                var type = e.display !== true ? e.display : e.type

                out += '<span class="app-set-field">';
                out += '<label class="uk-text-small">';
                out += (e.label || e.name);
                out += '</label><span>';

                if (type === 'set') { // take care of nested sets
                    out += App.Utils.renderer[type](v[e.name], e);
                } else {
                    out += (App.Utils.renderer[type] || App.Utils.renderer.default)(v[e.name]);
                }

                out += '</span></span>';

            }
        });
    }

    if (out !== '') return out;

    // display items count if output is empty
    var cnt = Object.keys(v).length;
    return '<span class="uk-badge">'+(cnt+(cnt ==1 ? ' Item' : ' Items'))+'</span>';

};
```

**custom.css**

```css
.app-set-field {
  position: relative;
  padding: 15px; }
  .app-set-field label {
    position: absolute;
    top: 0; }
  .app-set-field .app-set-field {
    padding: 0 15px 0 0; }
    .app-set-field .app-set-field label {
      position: relative;
      vertical-align: top;
      margin: 0 .2rem 0 0; }
```

## Screenshots

![cp-set-with-items-count](https://user-images.githubusercontent.com/13042193/48126407-4751c580-e281-11e8-8006-0d63add7b371.png)

![cp-set-sortable-with-item-count](https://user-images.githubusercontent.com/13042193/48126406-4751c580-e281-11e8-9539-a7ceef43be52.png)

![cp-set-grid-view](https://user-images.githubusercontent.com/13042193/48126405-4751c580-e281-11e8-9b81-71fe54344672.png)
