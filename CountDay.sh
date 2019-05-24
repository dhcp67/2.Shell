#!/bin/bash
a=$1
b=$2
n=$[ a+b ]
sum=0
#expr
for (( i=a; i < n; i++)); do
    mod=$[ i%100 ]
    ret=$[ i%400 ]
    cnt=$[ i%4 ]
    if [[ $mod -eq 0 && $ret -eq 0 ]]; then
        sum=$[ sum+366 ]
    elif [[ $mod -ne 0 && $cnt -eq 0 ]]; then
        sum=$[ sum+366 ]
    elif [[ $ret -ne 0 ]]; then
        sum=$[ sum+365 ]
    fi
done
echo $sum
