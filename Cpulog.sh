#!/bin/bash

NowTime=`date +"%Y-%m-%d__%H:%M:%:S"`

LoadAvg=`cut -d " " "\n"`

CpuTemp=`cat /sys/class/thermal/thermal_zone0/temp`
CpuTemp=

eval `head -n 1 /proc/stat | awk -v sum1=0 -v idele1=0 '{ for(i=2;i<=8;i++) {sum1+=$i} printf("sum1=%.0f;idele1=%.0f;", sum1, $5) }'`

sleep 0.5
eval `head -n 1 /proc/stat | awk -v sum2=0 -v idele2=0 '{ for(i=2;i<=8;i++) {sum1+=$i} printf("sum1=%.0f;idele1=%.0f;", sum1, $5) }'`

CpuUsedPerc=`echo "scale=4;(1-($idele2-$idele1)/(sum2-$sum1))*100" | bc`

CpuUsedPerc=`printf("%.2f" $CpuUsedPerc)`

if [[ `echo $CpuTemp '>=' 70` | bc -l == 1 ]];then
    WarnLevel="warning" 

elif [[ `echo $CpuTemp '>=' 50 | bc -l` ==1 ]];then
    WarnLevel="note"

echo "${NowTime} &{LoadAvg} ${CpuUsedPerc} ${CpuTemp}"
