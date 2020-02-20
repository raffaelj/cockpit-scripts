# SEO field for Cockpit CMS

## Options

```js
{
    "advanced": true,                 // (bool),   default: false
    "hide": ["canonical"],            // (array),  default: []
    "fallback": {                     // (object), default: {}
        "title": "title",             // field name, that is used as fallback
        "description": "excerpt",
        "image": "featured_image"
    },
    "spacer": " | ",                  // (string), default: " - "
    "branding": "CpMultiplane Demo",  // (string), default: ""
    "container": false,               // (bool),   default: true
}
```

## to do:

* [ ] renderer in entries view (save score/status ???)
* [x] hide andvanced options
* [ ] fallback to global site seo meta (request to get data from site singleton) ???
* [x] color code score/status
* [x] image fallback for field "featured_image"
* [ ] highlight focus keywords https://stackoverflow.com/a/7924240
* improve scoring
  * [x] length
  * [ ] pixel width
  * [ ] focus keywords
  * [ ] real words (ignore useless chars for counting)
* [ ] canonical
* [ ] schemas
* [ ] more/better help texts
* [ ] test/improve performance
