#!/bin/bash

printf 'base biblios\nf and\nshow 1\n' | yaz-client $(xmlstarlet sel -t -v 'yazgfs/listen' $KOHA_CONF | grep biblio) | grep -q '001 '
if [ $? == 0 ]; then
   echo "OK - z39.50 query returned results"
   exit 0
else
   echo "CRITICAL - z39.50 query failed"
   exit 0
fi
