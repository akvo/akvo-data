#!/bin/bash
set -e

rm -f /usr/lib/ckan/default/src/akvo-opendata
sudo -H -u root ln -s /vagrant/akvo-opendata/checkout /usr/lib/ckan/default/src/akvo-opendata
