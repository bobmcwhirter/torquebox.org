#!/bin/sh

rm -Rf _site _tmp
../awestruct/bin/awestruct --url http://staging.torquebox.org/ --force
rsync -rv --delete ./_site/ torquebox.org:/var/www/domains/torquebox.org/staging/htdocs/
