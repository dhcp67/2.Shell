#!/bin/bash
TimeBegin=`date +%s`
RestBegin=0


function CheckMin() {
    TimeNow=`date +%s`
    TimeBetween=$[ (${TimeNow} - ${TimeBegin}) / 60 ]
    if [[ ${TimeBetween} -ge 45 ]]; then
        return 1
    fi
    return 0
}

function RestTime() {
    TimeNow=`date +%s`
    TimeBetween=$[ ${TimeNow} - ${RestBegin} ]
    if [[ ${TimeBetween} -ge 5 ]]; then
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
    sleep 40
    CheckMin
    if [[ $? -eq 1 ]]; then
        echo "45"
    fi
    RestBegin=`date +%s`
    RestTime
    if [[ $? -eq 1 ]]; then
        echo "Rest Time out"
    fi
    TimeBegin=`date +%s`
    CheckZero
    if [[ $? -eq 1 ]]; then
        echo "00"
    fi
done
