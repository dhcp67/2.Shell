#!/bin/bash
for i in `seq 0 1000`; do
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
for i in `seq 2 1000`; do
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
