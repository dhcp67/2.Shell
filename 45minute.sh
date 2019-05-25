#!/bin/bash
TimeBegin=`date +%s`
RestBegin=0


function CheckMin() {
    TimeNow=`date +%s`
    TimeBetween=$[ (${TimeNow} - ${TimeBegin}) ]
    if [[ ${TimeBetween} -ge 10 ]]; then
    echo "已经45分钟了，休息5分钟"
    sleep 5
    TimeNow=`date +%s`
    TimeBetween=$[ ${TimeNow} - ${RestBegin} ]
    if [[ ${TimeBetween} -ge 5 ]]; then
        echo "Rest time out"
    fi
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
    sleep 5
    CheckMin
    RestBegin=`date +%s`
    TimeBegin=`date +%s`
    CheckZero
    if [[ $? -eq 1 ]]; then
        echo "00"
    fi
done
