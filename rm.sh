#!/bin/bash
Hostname=`hostname`
echo "${Hostname}"
Names=`cat /etc/passwd | awk -F: '{if ($3>1000 && $3 != 65534)  printf("%s ", $1)}'`
for i in $Names; do
    echo $i
    File="/home/${i}/.ssh/authorized_keys"
    echo $File
    if [[ -f $File ]]; then 
        #rm -f ${File} && 
        echo "Rm OK !"
        else
            continue
        fi
done
