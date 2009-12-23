#!/bin/sh
SELF_DIR=`dirname $0`

if [ ! -f $1 -o  ! -r $1 ]; then
  echo "Usage: $0 [JavaScript Source File]";
  exit 1
fi

js ${SELF_DIR}/js/jslint.js $1 "`cat $1`"
exit 0
