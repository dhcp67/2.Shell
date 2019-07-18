#!/bin/bash

NOWTIME=`date +"%Y-%m-%d__%H:%M:%S"`


PID=(`ps -aux | cut -b 11-15`); 
CPU=(`ps -aux | cut -b 17-21`); 
MEM=(`ps -aux | cut -b 21-26`); 

 for i in ${!CPU[@]}; do
    if [[ i -eq 1  ]]; then 
        continue
    fi
    if [[ CPU[$i] -ge 50 ]]; then
        ret=(${ret} $i);
    fi
    if [[ MEM[$i] -ge 50 ]]; then
        ret=(${ret} $i);
    fi
 done
 
echo $NOWTIME

