#!/bin/bash

PWD=$(pwd)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../../vagrant

CONF=`mktemp vagrant-ssh-conf.XXXXXX`
vagrant ssh-config > $CONF
ssh -t -F $CONF default "sudo tail -n 100 -f /var/log/apache2/ckan_default.$1.log"
rm $CONF

cd $PWD
