#!/bin/bash

echo $NowTime

DyAver=$1

if [[ ${DyAver}x == "x" ]];then
    exit 1
fi

MemValue=(`free -m | head -n 2| tail -n 1 | awk '{printf("%d %d", $3, $2)}'`)

MemAvaPer=`echo "scale=1;${MemValue[0]}*100/$MemAvaPer[1]}" | bc`

DyAver=`echo "scale=1;${DyAver}*0.3+${MemAvaPer}*0.7" | bc`

NowTime=`date +"%Y-%m-%d-%H:%M:%S"`

echo "${NowTime} ${MemValue[1]} ${MemAvaPer} "
