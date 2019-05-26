#!/bin/bash
MAX=1000
for i in `seq 2 ${MAX}`; do
    if [[ ${arr[$i]} -ne 1 ]]; then
        arr[0]=$[ ${arr[0]}+1 ]
        arr[${arr[0]}]=$i
    fi
        for j in `seq 1 ${arr[0]}`; do
		if [[ $[ ${arr[$j]}*$i ] -gt 1000 ]]; then
            break
        fi
        arr[$[ ${arr[$j]}*$i ]]=1
        if [[ $[ ${i}%${arr[$j]} ] -eq 0 ]]; then
            break
        fi
	done
done
arr[$[ ${arr[0]}+1 ]]=0
for (( i = 1; i <= arr[0]; i++ )); do
    arr[$[ ${arr[0]}+1 ]]=$[ ${arr[$[ ${arr[0]}+1 ]]}+${arr[$i]} ]
    echo ${arr[$i]}
done
echo ${arr[$[ ${arr[0]}+1 ]]}
