<?php

/*
  custom API endpoint for Cockpit
  returns markdown file with yaml frontmatter for jekyll
  
  place this file in /cockpit/config/api/collections/jekyll.php
  
  call it with https://urltocockpit.de/api/collections/jekyll
  and send json like : {"limit":"1","lang":"en","collection":"dates"}
  
  To do:
  
  * [ ] be aware of jekyll specific fields like "date"
  * [ ] API endpoint for multiple entries (with delimiter? Offer zip download? ...)
  
  
*/

// set params and options
// copy from cockpit/modules/Collections/Controller/RestApi.php function get()

$options = [];

if ($filter   = $this->param('filter', null))   $options['filter'] = $filter;
if ($limit    = $this->param('limit', null))    $options['limit'] = intval($limit);
if ($sort     = $this->param('sort', null))     $options['sort'] = $sort;
if ($fields   = $this->param('fields', null))   $options['fields'] = $fields;
if ($skip     = $this->param('skip', null))     $options['skip'] = intval($skip);
if ($populate = $this->param('populate', null)) $options['populate'] = $populate;

// cast string values if get request
if ($filter && isset($_GET['filter'])) $options['filter'] = $this->_fixStringBooleanValues($filter);
if ($fields && isset($_GET['fields'])) $options['fields'] = $this->_fixStringBooleanValues($fields);

// fields filter
$fieldsFilter = [];

if ($fieldsFilter = $this->param('fieldsFilter', [])) $options['fieldsFilter'] = $fieldsFilter;
if ($lang = $this->param('lang', false)) $fieldsFilter['lang'] = $lang;
if ($ignoreDefaultFallback = $this->param('ignoreDefaultFallback', false)) $fieldsFilter['ignoreDefaultFallback'] = $ignoreDefaultFallback;
if ($user) $fieldsFilter["user"] = $user;

if (is_array($fieldsFilter) && count($fieldsFilter)) {
    $options['fieldsFilter'] = $fieldsFilter;
}

if ($sort) {

    foreach ($sort as $key => &$value) {
        $options["sort"][$key]= intval($value);
    }
}

// set collection from param or default to "pages"  
$collection = $this->param('collection', null) ? $this->param('collection', null) : 'pages';

// find filtered entries or return warning if collection does not exist
if( !$posts = cockpit('collections')->find($collection, $options) )
  return "Collection does not exist.";

// return warning if multiple entries
if( count($posts) > 1 )
  return "This output is meant for single pages. Please use limit or filter by _id.";

// extract content if it exists
$content = "";

if(isset($posts[0]['content'])){
  $content = $posts[0]['content'];
  unset($posts[0]['content']);
}

// build md file with yaml frontmatter
$out = "";

$out .= "---\r\n";

$out .= $this->helper('yaml')->toYAML($posts[0]);

$out .= "---\r\n";

$out .= $content;

// set mimetype to txt
$this->response->mime = 'txt';

// set filename
$title = isset($posts[0]['title']) ? $posts[0]['title'] : $collection."-".$posts[0]['_id'];

$filename = $this->helper('utils')->sluggify($title);

$this->response->headers[] = "Content-Disposition: inline; filename=\"$filename\"";

// return text file
return $out;
