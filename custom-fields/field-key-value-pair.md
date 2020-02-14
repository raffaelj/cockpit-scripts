# key-value-pair field

## Options

```json
{
    "prefix": "og:",    // (string), default: ""
    "format": "array",  // (string), default: "object"
    "limit": 5,         // (int),    default: 0 (unlimited)
    "sortable": true,   // (bool),   default: false
    "safeDelete": true, // (bool),   default: false
}
```

### safeDelete

Confirm in an ui modal before deleting an item.

### sortable

Change the order of the items via drag and drop.

### limit

Limit the amount of items.

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
    "image": "image_url"
  }
]
```