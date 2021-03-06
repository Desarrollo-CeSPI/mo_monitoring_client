#!/bin/bash
# Written by Damien Gy
# damien.gy+nagiosexchange(AT)gmail.com
# 2007-09-28

PROGNAME=`basename $0`
REVISION=1.00
TMP=/tmp/tmpdig
DIG=/usr/bin/dig

print_revision() {
  echo $PROGNAME $REVISION
}

print_usage() {
  echo "Usage:"
  echo "  $PROGNAME -c|--check <host> <type> <server>"
  echo "  $PROGNAME -h|--help"
  echo "  $PROGNAME -v|--version"
}

print_help() {
  print_revision
  echo ""
  print_usage
  echo "Where:"
  echo "  host  the name of the resource record to be looked up"
  echo "  type  indicates the query required (any, a, mx, etc.)"
  echo "  server  the name or IP address of the name server to query"
  echo ""
  echo "  -h|--help prints this help screen"
  echo ""
  echo "  -v|--version  prints version and license information"
  echo ""
  echo " Created by Damien Gy, questions or problems e-mail damien.gy+nagiosexchange(AT)gmail.com"
  echo ""
}

check_dns() {

  if [ $# -ne 3 ]
  then
          echo "Number of arguments incorrect"
          exit 3
  fi
  if [ ! -e $DIG ]
  then
    echo "$DIG not found"
    exit 3
  fi
  $DIG $1 $2 @$3 > $TMP

  if ( grep "status" $TMP > /dev/null )
  then
          # DNS server answered
          if ( grep "NOERROR" $TMP > /dev/null )
          then
                  echo "DNS OK "`grep "time:" $TMP`
                  rm -f $TMP
                  exit 0
          else
                  echo "WARNING "`grep "time:" $TMP`
                  rm -f $TMP
                  exit 1
          fi

  else
          # no answer
          echo "CRITICAL - Connection timed out"
          rm -f $TMP
          exit 2
  fi
}

case "$1" in
--help)
                print_help
        exit 0
        ;;
-h)
                print_help
        exit 0
        ;;
--version)
                print_revision
        exit 0
        ;;
-v)
                print_revision
        exit 0
        ;;
--check)
                check_dns $2 $3 $4
        ;;
-c)
                check_dns $2 $3 $4
        ;;
*)
                print_usage
        exit 3

esac
