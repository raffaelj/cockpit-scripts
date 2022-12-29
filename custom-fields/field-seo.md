# SEO field for Cockpit CMS v1

## Options

```js
{
    "advanced":         true,             // (bool),   default: false
    "hide": [                             // (array),  default: []
        "title",
        "description",
        "canonical",
        "og",
        "twitter",
        "robots",
        "canonical"
    ],
    "fallback": {                         // (object), default: {}
        "title":        "title",          // field name, that is used as fallback
        "description":  "excerpt",
        "image":        "featured_image"
    },
    "spacer":           " | ",            // (string), default: " - "
    "branding":         "My site",        // (string), default: ""
    "spacer_de":        " | ",            // localize custom spacer and branding
    "branding_de":      "Meine Seite"
    "optsFromRequest":  "/my-opts"        // (string), default: null
    "container":        false,            // (bool),   default: true (experimental)
}
```

### advanced

Display OG, Twitter, robots and canonical options by default. They can always turned off/on with a toggle button, even without setting `advanced` to `true`.

### hide

Hide parts from the seo field.

### fallback

Set field names, that are used as fallback values, if no custom value is set via the seo field, e. g. `title` or `description`.

### spacer

Set a custom spacer (preview only). Use `spacer_<locale>` for localized values.

### branding

Set a custom branding (preview only). Use `branding_<locale>` for localized values.

### optsFromRequest

Set an admin route to recieve custom (localized) spacer and branding, when the field loads.

### container

The field has multiple nested fields with theire own field containers (gray bars on the left side). Settings `container` to `false` removes the parent container and it doesn't look like nested fields anymore (experimental):

## To do

* [ ] renderer in entries view (save score/status ???)
* [x] hide andvanced options
* [x] fallback to global site seo meta (request to get data from site singleton) ???
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

## CHANGELOG

### 0.2.0

* huge code refactoring
* replaced `addBranding` (default: true) with `hideBranding` (default: false)
* config and advanced options are now localizable
* fixed updating and object property mutation issues
* moved config (spacer, branding) options from side bar to normal field view (solves updating issues)
* moved field info from bottom to top of field (cockpit core default is bottom)
* improved localization
* improved accessibility (still very inaccessible)
* added `optsFromRequest` option to use a custom admin route for spacers and brandings - useful for consistant previews in multiple collections without updating the field options all over the place
* added option to localize spacer and branding previews
