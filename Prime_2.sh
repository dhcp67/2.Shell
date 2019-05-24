#!/bin/bash
for i in `seq 0 1005`; do
	arr[$i]=0
done
for (( i = 2; i <= 1000; i++)); do
    if [[ ${arr[$i]} -eq 0 ]]; then
        arr[0]=$[ ${arr[0]}+1 ]
        arr[${arr[0]}]=$i
    fi
	for(( j = 1; j <= ${arr[0]}; j++)); do
		if [[ $[ ${arr[$j]}*$i ] -gt 1000 ]]; then
            break
        fi
        arr[$[ ${arr[$j]}*$i ]]=1
        if [[ $[ ${i}%${arr[$j]} ] -eq 0 ]]; then
            break
        fi
	done
done
ret=$1
for (( i = 1; i <= ret; i++ )); do
    arr[0]=$[ ${arr[0]}+${arr[$i]} ]
    echo ${arr[$i]}
done
