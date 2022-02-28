#!/bin/bash

array=("<url without protocol>", "< .... >")


for str in ${array[@]}; do
  ip=$(dig +short $str)

  s=''
  for addr in $ip; do
    echo \"$str$s\": \"$addr\",
    s="${s}/"
  done

done
