#!/usr/bin/env bash
OUTPUT=$($CZ helm template --quiet 2>&1)
# debug
# echo "$OUTPUT"
if [ $? -eq 0 ]
then
   echo "OK"
else
  echo $OUTPUT
fi
