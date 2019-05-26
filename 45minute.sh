#!/bin/bash
TimeBegin=`date +%s`
RestBegin=`date +%s`


function CheckMin() {
    TimeNow=`date +%s`
    TimeBetween=$[ (${TimeNow} - ${TimeBegin}) / 60 ]
    if [[ ${TimeBetween} -ge 2 ]]; then
        return 1
    fi
    return 0
}

function RestTime() {
    TimeNow=`date +%s`
    TimeBetween=$[ ${TimeNow} - ${RestBegin} / 60 ]
    if [[ ${TimeBetween} -ge 1 ]]; then
        return 1
    fi
    return 0
}

function CheckZero() {
    Mini=`date +%M`
    if [[ ${Mini} == "00" ]]; then
        return 1
    fi
    return 0
}

while [[ true ]]; do
    sleep 10
    CheckMin
    if [[ $? -eq 1 ]]; then
        export DISPLAY=:0.0 && notify-send "Time to Rest"
        RestBegin=`date +%s`
        TimeBegin=`date +%s`
    fi
    if [[ ! ${RestBegin}x == x ]]; then
    RestTime

    if [[ $? -eq 1 ]]; then
        export DISPLAY=:0.0 && notify-send "Rest Time out"
    fi
    fi
    CheckZero
    if [[ $? -eq 1 ]]; then
        export DISPLAY=:0.0 && notify-send "00"
    fi
done
