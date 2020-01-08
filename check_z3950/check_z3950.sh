#!/bin/bash

usage()
{
  echo "usage: nagios_check_z3950 -c instance_name [-c instance_name]"
}

# function to test if z39/zebra is returning results
test_z39 () {
  local YAZ_TEST=$1
  local TEST=
  TEST=$(printf 'base biblios\nf and\nshow 1\n' | yaz-client ${YAZ_TEST} | grep -q '001 ' ; echo $?)

  return $TEST
}

NAGOUT=
STATE=0

while [ "$1" != "" ]; do
  YAZ_TEST=
  case $1 in
    -i | --instance)  shift
                      INST=$(echo "$1" | cut -d: -f1)
                      YAZ_PORT=$(echo "$1" | cut -d: -f2)
                      YAZ_TEST="tcp:0.0.0.0:${YAZ_PORT}"
                      RESULT=$(test_z39 $YAZ_TEST ; echo $?)
                      case $RESULT in
                        0 )
                          NAGOUT="$NAGOUT; OK - $1"
                          ;;
                        1 )
                          NAGOUT="$NAGOUT; CRITICAL - z39.50 query failed for $1"
                          STATE=2
                          ;;
                      esac
                      ;;
  esac
  shift
done


# cleanup nagios output, remove extraneous '; '
NAGOUT=$(echo $NAGOUT | sed "s/^; //")
echo "$NAGOUT"
exit $STATE
