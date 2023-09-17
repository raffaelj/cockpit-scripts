<?php
/**
 * Transform collection entries
 */

namespace Migrate\Helper;

class TransformFields extends \Lime\Helper {

    private $isCockpitV2;

    /**
     * Check cockpit version
     *
     * Method is called from parent constructor
     */
    public function initialize() {

        $this->isCockpitV2 = class_exists('Cockpit')
            && defined('APP_VERSION')
            && version_compare(APP_VERSION, '2.0', '>=');

    }

    public function convertModelFields(array $fields): array {

        foreach ($fields as &$field) {

            $type = $field['type'] ?? 'text';
            $method = "_{$type}";
            if (method_exists($this, $method)) {
                $field = $this->$method($field);
            }

        }

        return $fields;

    }

// {
//     "label": false,
//     "default": false,
//     "cls": "" // custom class
// }
    public function _boolean(array $field): array {

        $field['type'] = 'boolean';

        $options = fixToArray($field['options'] ?? []);

        if (!empty($options['label'])) {
            $field['opts'] = [
                'label' => false,
            ];
        }

        return $field;
    }

    public function _select(array $field): array {

        $field['type'] = 'select';

        $options = fixToArray($field['options'] ?? []);

        if (!empty($options['options'])) {

            $o = $options['options'];

            // supported in v2
            $isCommaSeparatedString = is_string($o);
            // supported with GUI in v2
            $isArrayOfStrings       = is_array($o) && isset($o[0]) && is_string($o[0]);
            // supported in v2
            $isArrayOfObjects       = is_array($o) && isset($o[0]['value']);

            // not supported in v2
            $isKeyValueObject       = is_array($o) && !isset($o[0]) && is_string(array_keys($o)[0]);

            // convert string to array
            if ($isCommaSeparatedString) {
                $o = array_map('trim', explode(',', $o));
            }

            // convert to array of objects
            if ($isKeyValueObject) {
                $o = array_map(function($k, $v) {
                    return [
                        'value' => $k,
                        'label' => $v,
                    ];
                }, array_keys($o), array_values($o));
            }

            $field['opts']['options'] = $o;
        }

        return $field;
    }

    public function _multipleselect(array $field): array {

        $field = $this->_select($field);

        $field['opts'] = fixToArray($field['opts'] ?? []);

        $field['opts']['multiple'] = true;

        return $field;
    }

// {
//   "cls": "",
//   "maxlength": null,
//   "minlength": null,
//   "step": null,
//   "placeholder": null,
//   "pattern": null,
//   "size": null,
//   "slug": true
// }
    public function _text($field) {

        $field['type'] = 'text';

        $field['opts'] = [
            'multiline'   => false,
            'showCount'   => true,
            'readonly'    => false,
            'placeholder' => NULL,
            'minlength'   => NULL,
            'maxlength'   => NULL,
            'list'        => NULL,
        ];

        $options = fixToArray($field['options'] ?? []);

        if (isset($options['minlength']) && is_numeric($options['minlength'])) {
            $field['opts']['minlength'] = $options['minlength'];
        }

        if (isset($options['maxlength']) && is_numeric($options['maxlength'])) {
            $field['opts']['maxlength'] = $options['maxlength'];
        }

        return $field;

    }

// {
//   "cls": "",
//   "allowtabs": true,
//   "maxlength": null,
//   "minlength": null,
//   "placeholder": null,
//   "cols": null,
//   "rows": null
// }
    public function _textarea($field) {

        $field['type'] = 'text';

        $field['opts'] = [
            'multiline'   => true,
            'showCount'   => true,
            'readonly'    => false,
            'placeholder' => NULL,
            'minlength'   => NULL,
            'maxlength'   => NULL,
            'list'        => NULL,
        ];

        $options = fixToArray($field['options'] ?? []);

        if (isset($options['minlength']) && is_numeric($options['minlength'])) {
            $field['opts']['minlength'] = $options['minlength'];
        }

        if (isset($options['maxlength']) && is_numeric($options['maxlength'])) {
            $field['opts']['maxlength'] = $options['maxlength'];
        }

        return $field;

    }





    // convert entries



    /**
     * Convert `rgb(255,255,0)` to `#FFFF00`
     */
    public function e_color($str, $lowerCase = false) {

        if (!is_string($str)) return '';

        if (strpos($str, '#') === 0) {
            return $lowerCase ? $str : strtoupper($str);
        }

        preg_match('/rgb\( *(\d{1,3} *, *\d{1,3} *, *\d{1,3}) *\)/i', $str, $matches);

        $channels = explode(',', $matches[1]);
        [$red, $green, $blue] = array_map('trim', $channels);

        $str = sprintf("#%02x%02x%02x", $red, $green, $blue);

        return $lowerCase ? $str : strtoupper($str);
    }


    /**
     * Transform `'published' => true|false` to `'_state' => 1|0`
     */
    public function booleanPublishedToState($entry) {

        $isPublished = isset($entry['published']) && $entry['published'] === true;

        $entry['_state'] = $isPublished ? 1 : 0;
        unset($entry['published']);

        return $entry;

    }

    /**
     * Transform gallery to asset (multiple)
     */
    public function galleryToAssetMultiple($entry, $field) {

        

        return $entry;

    }

}

// helper

/**
 * Turn null or empty string to array
 */
function fixToArray($v = null) {
    return isset($v) && is_array($v) ? $v : [];
}
