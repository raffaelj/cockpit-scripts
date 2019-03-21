# Simple Repeater

Custom field for [Cockpit CMS](https://github.com/agentejo/cockpit)

A simpler repeater field, than the original one. I modified the code of the original component, so credits go to @aheinze.

Copy the file `field-simple-repeater.tag` to `config/tags`

## difference to original repeater field

short answer: lesser features, cleaner output

**long answer:**

The original repeater field saved the field options in the data, too.

output of original repeater:

```json
"repeaterfield": [
    {
        "field": {
            "type": "text",
            "label": "Something 01"
        },
        "value": "value 01"
    },
    {
        "field": {
            "type": "text",
            "label": "Something 02"
        },
        "value": "whatever"
    }
]
```

output of simple-repeater (output is always an array):

```json
"simplerepeater": [
    "value 01",
    "whatever"
],
```

--> no field definitions, just values

## Options

```
{
    "field": {"type": "text", "label": "Something"},
    "limit": null
}
```
