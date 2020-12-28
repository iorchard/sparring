#!/bin/bash
URL=$1
PASSCODE=$2
OUT=$3
rm -f $OUT

while true;do
  scode=$(curl -s -w "%{http_code}" -o /dev/null -m 2 $URL)
  ts=$(date +%FT%T)
  [ "$PASSCODE" == "$scode" ] && msg="PASS" || msg="FAIL"
  echo "$ts $msg($scode)" >> $OUT
  sleep 1
done
