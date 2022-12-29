# Key/value pair field for Cockpit CMS v1

## Options

```js
{
    "prefix": "og:",                         // (string), default: ""
    "format": "array",                       // (string) "array|object", default: "object"
    "limit": 5,                              // (int),    default: 0 (unlimited)
    "sortable": true,                        // (bool),   default: false
    "safeDelete": true,                      // (bool),   default: false
    "defaultKeys" : ['title', 'description'] // (array),  default: []
    "displayPrefix" : "og:"                  // (string), default: ""
}
```

### safeDelete

Confirm in an ui modal before deleting an item.

### sortable

Change the order of the items via drag and drop.

### limit

Limit the amount of items.

### defaultKeys

Display default keys with empty values. If the field has data (entry was saved before), the default fields aren't displayed.

### prefix

Set a key prefix for all key-value pairs, so you don't have to type it over and over again.

output (format: array, prefix: og):

```json
"meta": [
  {
    "og:type": "website"
  },
  {
    "og:image": "image_url"
  },
  {
    "og:image": "image_url"
  }
]
```

### displayPrefix

Display a key prefix only while editing. Other than the `prefix`, the `displayPrefix` won't be added to the saved key names.

### format

#### object output

If you have duplicated keys, the last one will be saved. Duplicates are marked red.

```json
"og": {
  "type": "website",
  "image": "image_url"
},
```

#### array output

The array output allows duplicates. Duplicates are marked light blue.

```json
"og": [
  {
    "type": "website"
  },
  {
    "image": "image_url"
  },
  {
    "image": "another_image_url"
  }
]
```

## CHANGELOG

### 0.2.0

* improved accessibility
* fixed updating issues (e. g., if changing parent language) and possible object mutation with `defaultKeys` if value is null
* some code cleanup
* improved performance if no prefix is specified
