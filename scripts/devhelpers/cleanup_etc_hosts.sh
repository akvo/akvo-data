#!/bin/bash

TMP_FILE=`mktemp /tmp/tmphosts`
sed '/# localdev_opendata/d' /etc/hosts > $TMP_FILE
sudo mv $TMP_FILE /etc/hosts
