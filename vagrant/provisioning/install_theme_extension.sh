#!/bin/bash
set -e

# install the extension
sudo -s . /usr/lib/ckan/default/bin/activate
cd /usr/lib/ckan/default/src/akvo-opendata/ckanext-akvo
python setup.py develop

# add plugin into ckan.plugins setting in CKAN config file
if ! grep ckan.plugins /etc/ckan/default/production.ini | grep akvo > /dev/null; then
    sudo sed -i -e '/^ckan.plugins/ s/$/ akvo/' /etc/ckan/default/production.ini
fi
