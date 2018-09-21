#!/bin/bash

################################################################################
#
# install Cockpit (https://getcockpit.com) on a limited shared host from strato
# Git is not available, so we can't just `git clone` and `git pull` for updates.
#
# `ssh domain@ssh.strato.de`, type your master password
# copy this file into your home dir, make it executable `chmod 744 ./install.sh`
# and run it `./install.sh`
#
# adjust the settings below for your needs

# your domain or subdomain points to this dir
root=redesign

# the name of your cockpit
cockpitdir=admin

# source of cockpit
repo=https://github.com/agentejo/cockpit/archive/next.zip

# i18n for the backend
lang=de
i18nfile=https://raw.githubusercontent.com/COCOPi/cockpit-i18n/master/$lang.php

# config
appname=Admin-Area

################################################################################

cockpit=$root/$cockpitdir

# create root and cockpit dirs
mkdir -p $cockpit

# The naming convention for zips from Github is `reponame-treename.zip`
# The archive contains a single folder named `reponame-treename`, that
# contains the cockpit files. So 

tmpdir=`mktemp -d`
# tmpdir=/tmp/tmp.AlZgWkK5OY

echo downloading Cockpit from $repo
wget -q -O $tmpdir/cptmp.zip $repo

unzip -q $tmpdir/cptmp.zip -d $tmpdir/unzipped
dir="$(echo $tmpdir/unzipped/*)"

cp -r $dir/. $cockpit
# rm -r $tmpdir/unzipped
rm -r $tmpdir
echo copied cockpit into $cockpit and deleted temporary files

# define paths, because Cockpit has problems with some redirects and symlinks
# https://github.com/agentejo/cockpit/issues/704
cat > $cockpit/defines.php <<EOF
<?php
define('COCKPIT_BASE_URL', '/$cockpitdir');
define('COCKPIT_BASE_ROUTE', '/$cockpitdir');
define('COCKPIT_DOCS_ROOT', dirname(__DIR__));
EOF
echo created defines.php with custom paths

# copy i18n for the backend
mkdir -p $cockpit/config/cockpit/i18n
wget -O $cockpit/config/cockpit/i18n/$lang.php $i18nfile
echo downloaded and saved i18n file for backend

# create config file
# to do...
# config=

cat > $cockpit/config/config.yaml <<EOF
app.name: $appname
i18n: $lang
EOF

# run install to create admin user
#
# didn't test on the remote, but worked on local machine
# output is ugly, because it's the whole html...

#php $cockpit/install/index.php
