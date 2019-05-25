#!/bin/bash
while true; do
    sleep 5
    export DISPLAY=:0.0 && notify-send "休息5分钟"
	sleep 5
    export DISPLAY=:0.0 && notify-send "已经休息5分钟了"
done&
while true; do
    ret=`date +%M`
    if [[ ret = 55 ]]; then
        export DISPLAY=:0.0 && notify-send "`date +%H:%M:%S`"
    fi
    sleep 1
done&
