#!/bin/bash
while true; do
    sleep 2700
    export DISPLAY=:0.0 && notify-send "休息5分钟"
	sleep 300
done&
while true; do
    if [[ `date +%M` = 00 ]]; then
        export DISPLAY=:0.0 && notify-send "`date +%H`:`date +%M`"
    fi
    sleep 30
done&
        export DISPLAY=:0.0 && notify-send "`date +%H`:`date +%M`"
