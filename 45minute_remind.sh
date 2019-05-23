#!/bin/bash
while true; do
    sleep 2700
    export DISPLAY=:0.0 && notify-send "休息5分钟"
	sleep 300
done&
while true; do
    export DISPLAY=:0.0 && notify-send "date +%H:%M"
    sleep 30
done
