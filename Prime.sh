#!/bin/bash
MAX=1000
sum=0
for i in `seq 2 ${MAX}`; do
    if [[ ${arr[$i]} -ne 1 ]]; then
        arr[0]=$[ ${arr[0]}+1 ]
        arr[${arr[0]}]=$i
        sum=$[ ${sum}+${arr[${arr[0]}]} ]
        echo ${arr[${arr[0]}]}

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
echo ${sum}
