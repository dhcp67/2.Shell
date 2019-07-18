#!/bin/bash

eval $(ps -aux --sort=-%cpu -h | awk -v num=0 \
    '{ if ($3 < 50) {exit} else{num++;printf("cpupid["num"]=%d;", $2)} END {printf("cpunum=%d;", num)}}'\
    )


eval $(ps -aux --sort=-%mem -h | awk -v num=0 \
    '{ if ($3 < 50) {exit} else{num++;printf("mempid["num"]=%d;", $2)} END {printf("memnum=%d;", num)}}'\
    )

if [[ ${cpunum} -gt 0  || ${memnum} -gt 0]];then
    sleep 5
else
    exit 0
fi

NowTime=`date +"%Y-%m-%d__%H:%M:%S"`

if [[ ${cpunum}  gt 0 ]]; then
    for i  in ${cpupid[*]}; do
        count=$[ ${count} + 1 ]
        eval $(ps -aux -q $i -h | awk -v num=${count++}\
            '{if ($3 < 50) {exit} else {nnum++;printf("cpupname["num"=%s];cpupid["num="]=%d;cpupuser["num"]=%s;cpupcpu["num"=%.2f];cpupmem["num"=%.2f]",$1, $2. $3. $4)}}'\
            )
    done
fi

