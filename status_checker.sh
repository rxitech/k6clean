#!/bin/bash

input="./hosts_to_check.txt"
while IFS= read -r link; do
  res=$(curl -s https://www.isitdownrightnow.com/check.php\?domain\=$link)
  if [[  $res =~ "DOWN"  ]]; then
    echo "$link is down"
  else
    echo "$link is still up"
  fi
  sleep 3
done < "$input"
