#!/bin/bash
for (( i = 1; i <= 1000; i++)); do
	arr[$i]=0
done
for (( i = 2; i*i <= 1000; i++)); do
	for(( j = i; i * j <= 1000; j++)); do
		arr[$[ i*j ]]=1
	done
done
sum=0
for (( i = 2; i <= 1000; i++)); do
	if [[ ${arr[$i]} -ne 1 ]]; then
		sum=$[ sum+i ]
		echo  $i
	fi
done
echo ${sum}
