<?php
/**
 * Copy this file into `/config/cli/assets-folder-import.php`
 * 
 * call it via `./cp assets-folder-import --dir /path/to/images --ext jpg,png --r`
 * 
 * @author:  Raffael Jesche
 * @license: MIT
 * @version: 0.1.0
 */

if (!COCKPIT_CLI) return;

$time = time();

$dir       = $app->param('dir', null);      // string   folder to import, required
$list      = $app->param('list', false);    // boolean  print file list, no import
$recursive = $app->param('r', false);       // boolean  import subfolders
$pattern   = $app->param('pattern', null);  // string   check files against shell wildcard pattern
$ext       = $app->param('ext', null);      // string   comma separated list, check files against file extensions

if (!$dir || $dir === true) {
    CLI::writeln('--dir parameter missing', false);
    return;
}
if ($ext && $ext === true) {
    CLI::writeln('--ext parameter is boolean, expected string with comma separated file extensions', false);
    return;
}
if ($pattern && $pattern === true) {
    CLI::writeln('--pattern parameter is boolean, expected string with shell wildcard pattern', false);
    return;
}

$dir = realpath($dir);
if ($ext) $ext = explode(',', $ext);

$files = [];
$folders = [];
$meta = [];

// create virtual parent folder
$folderName = basename($dir);
$folder = [
    'name' => $folderName,
    '_p' => '',
    '_by' => '',
];

if (!$list) {
    $pfid = $app->storage->save('cockpit/assets_folders', $folder);
    CLI::writeln("Created new virtual folder $folderName - $pfid");
} else {
    $pfid = 'id::'.$folderName;
}

$folders[$dir] = [
    'name' => basename($dir),
    'parent' => '',
    '_p' => '',
    '_id' => $pfid,
];

$fid = $pfid;

if ($recursive) {
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir), RecursiveIteratorIterator::SELF_FIRST);
} else {
    $iterator = new \DirectoryIterator($dir);
}


foreach ($iterator as $file) {

    $baseName = $file->getBasename();

    if ($baseName == '.' || $baseName == '..') continue;

    if (!$recursive && $file->isDir()) continue;

    if ($file->isDir()) {

        $folderName = $baseName;
        $pathName   = $file->getPathname();
        $parentPathName   = dirname($pathName);
        $parentFolderName = basename($parentPathName);

        if (!isset($folders[$pathName])) {
            $folder = [
                'name' => $folderName,
                '_p' => $folders[$parentPathName]['_id'] ?? '',
                '_by' => '',
            ];

            if (!$list) {
                $fid = $app->storage->save('cockpit/assets_folders', $folder);
                CLI::writeln("Created new virtual folder $folderName - $fid");
            } else {
                $fid = 'id::'.$folderName;
            }

            $folders[$file->getPathname()] = [
                'name' => $folderName,
                'parent' => $parentFolderName,
                '_p' => $folders[$parentPathName]['_id'] ?? '',
                '_id' => $fid,
            ];
        }

    }

    if ($pattern && !fnmatch($pattern, $baseName)) continue;
    if ($ext && !in_array($file->getExtension(), $ext)) continue;

    if (!$file->isDir()) {
        $files[] = $file->getRealPath();
        $meta[] = [
            'folder' => $fid
        ];
    }

}

// print file list
if ($list) {

    function createPathList($current, $arr) {
        $list = [$current['name']];
        foreach ($arr as $v) {
            if ($current['_p'] == 'id::'. $v['name']) {
                $sublist = createPathList($v, $arr);
                foreach ($sublist as $s) $list[] = $s;
                continue;
            }
        }
        return $list;
    }

    foreach ($folders as $folder) {

        $parents = implode(' > ', array_reverse(createPathList($folder, $folders)));

        CLI::writeln($parents, 'white');

        foreach ($files as $k => $file) {
            if ($folder['_id'] == $meta[$k]['folder']) {
                CLI::writeln('  ' . basename($file));
            }
        }
    }

    return;
}

// import assets
CLI::writeln('Start to import assets. This may take a while...');

$count = count($files);

foreach ($files as $k => $file) {

    $memory = $app->helper('utils')->formatSize(\memory_get_usage(true));
    $peak   = $app->helper('utils')->formatSize(\memory_get_peak_usage(true));
    $i = $k + 1;

    $return = $app->module('cockpit')->addAssets([$file], $meta[$k]);

    if (!empty($return)) CLI::writeln("Imported $i of $count files | mem: $memory | peak: $peak");
    else CLI::writeln("Failed $i of $count files | mem: $memory | peak: $peak", false);
}

$seconds = time() - $time;

CLI::writeln("Imported $count assets in $seconds seconds", true);
