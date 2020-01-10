# modified collectionlink field

Copy the file `field-collectionlink.tag` to `config/tags`.

Now the core field will be overwritten with the custom field and it is possible, to use multiple field names as display field.

modifications:

* added `concatDisplayString()` function
* call `concatDisplayString()` in `linkItem()` function
* added custom renderer for entries view with string concatanation

usage:

* define multiple field names in collectionlink field options
  to be displayed with collectionlink field
* e. g.: `"display": "{first_name} {last_name}"`
