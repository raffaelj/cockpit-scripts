<?php

/**
 * Filter populated items (collection-link field)
 *
 * By default, linked collection items are populated completely. To shrink the api response to a smaller
 * result set, you can use the event system to adjust some filter options.
 *
 * In this example I have a collection "software" with a collection link to the collection "repos".
 * The repos collection contains a lot of useles data, that I fetched earlier from the Github API.
 *
 * Discussion: https://discourse.getcockpit.com/t/beginner-how-does-populate-work/1667
 *
 * Usage:
 * 
 * Copy this snippet into `path/to/cockpit/config/bootstrap.php`
 * and change the collection names to match your setup.
 *
 * Fetch entries: `https://example.com/api/collections/entries/software?token=xxtokenxx`
 * JSON body: `{"populate":1,"populateFilter":{"_id":false,"name":true,"url":true}}`
 *
 */

// fire only on api requests and if populate param is true
if (COCKPIT_API_REQUEST && $app->param('populate', false)) {

    // fire only for "software" collection
    $app->on('collections.find.before.software', function($name, &$options) {

        // create event to filter populated "repos" collection
        $this->on('collections.find.before.repos', function($name, &$options) {

            // set the fields filter to prevent populating the whole entry
            // If no custom filter is set, default to "_id" and "full_name",
            // otherwise use the custom filter
            $options['fields'] = $this->param('populateFilter', [
                '_id'       => true,
                'full_name' => true,
            ]);

        });
    });
}
