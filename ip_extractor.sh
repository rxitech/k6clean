#!/bin/bash

array=("<url without protocol>", "< .... >")


for str in ${array[@]}; do
  ip=$(dig +short $str)

  for addr in $ip; do
    echo : \"$addr\": \"$str\",
  done

done
