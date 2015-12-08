#!/bin/bash
start=$1
key=ckczppom
number=$start

echo "starting at $start"

while true; do
  hash=$(echo -n $key$number | md5sum -)
  if [[ $hash =~ ^000000 ]]; then
    echo "$number produced hash $hash"
    break
  fi
  ((number+=6))

done
