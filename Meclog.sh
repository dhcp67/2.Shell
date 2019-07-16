#!/bin/bash

NowTime=`date +"%Y-%m-%d-%H-%M-%S"`

echo $NowTime

DyAver=$1

if [[ ${DyAver}x == "x" ]];then
    exit 1
fi


