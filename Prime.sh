#!/bin/bash
for (( i = 0; i <= 1000; i++)); do
	arr[$i]=0
done
for (( i = 2; i*i <= 1000; i++)); do
    if [[ ${arr[$i]} -eq 1 ]]; then
        continue
    fi
	for(( j = i; i * j <= 1000; j++)); do
		arr[$[ i*j ]]=1
	done
done
sum=0
ret=1
for (( i = 2; i <= 1000; i++)); do
	if [[ ${arr[$i]} -eq 0 ]]; then
		sum=$[ ${sum}+${i} ]
		arr[$ret]=$i
        ret=$[ ret+1 ]
	fi
done
for i in `seq 1 1000`; do
    if [[ ${arr[$i]} -eq 1 || ${arr[$i]} -eq 0 ]]; then
        break
    fi
    echo ${arr[$i]}
done
echo $sum
