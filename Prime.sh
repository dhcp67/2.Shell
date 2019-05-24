#!/bin/bash
for (( i = 1; i <= 1000; i++)); do
	arr[$i]=0
done
for (( i = 2; i*i <= 1000; i++)); do
    if [[ $arr[$i] -ne 0 ]]; then
        continue
    fi
	for(( j = i; i * j <= 1000; j++)); do
		arr[$[ i*j ]]=1
	done
done
for i in `seq 1 10`; do
        echo ${arr[$i]}
done
sum=0
ret=1
for (( i = 2; i <= 1000; i++)); do
	if [[ ${arr[$i]} -ne 1 ]]; then
		sum=$[ sum+i ]
		arr[$ret]=arr[$i]
        ret=$[ ret+1 ]
	fi
done
for i in `seq 1 10`; do
        echo ${arr[$i]}
done
echo $sum
