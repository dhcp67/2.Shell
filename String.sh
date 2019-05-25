#!/bin/bash

Len=( 0 0 0 )
Str=( 0 0 0 )
File=( 0 0 0 )
FilterConf="./filter.conf"

#$1=wenjian.txt  ./a/b/a.txt
function Filter() {
    FilterType=`besename | tr [.] "\n" | tail -1`
    grep -w -q "${FilterType}" ${FilterConf}
    if [[ $? -eq 0 ]]; then
        return 1    
    fi
    file $1 | grep -q -w "txt"
    if [[ $? -eq 1 ]]; then 
        return 1
    fi
    return 0
}

#$1 文件
function FindInFile() {
    Words=`cat $1 | tr -c -s "A-Za-z" "\n"`
    for i in ${worda}; do
        tmp=${#i}
        if [[ ${tmp} -ge ${Len[0]} ]]; then 
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Len[0]}
            Str[1]=${Str[0]}
            File[1]=${File[0]}
            Len[0]=${tmp}
            Str[0]=${i}
            File[0]=$1
        elif [[ ${tmp} -ge ${Len[1]}  ]];then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${tmp}
            Str[1]=${i}
            File[1]=$1
        elif [[ ${tmp} -ge ${Len[2]} ]];then
            Len[2]=${tmp}
            Str[2]=$i
            File[2]=$1
        fi
    done
    return 0
}
#$1 目录
function FindInDir() {
    for i in `ls -A`; do
        TestSame $1/$i 0 $#
        if [[ -f $1/$i ]]; then 
            FindInFile $1/$i
        elif [[ -d $1/$i  ]];then 
            FindInDir $1/$i
        else 
            return 
        fi
    done
}
for i in `echo $@`; do
    if [[ ! -e $i ]]; then 
        exit
    fi
    Args+=$i
done

#TestSame File StartSub FinshSub
function TestSame() {
    for (( x= $2; x < $3; x++ )); do
        if [[ $1 -ef ${Args[$x]} ]]; then
            echo "Same with Args"
            return 0
        fi
    done
    return 1
}

NumArgs=$#

echo ${!Args[*]}
for i in `echo ${!Args[@]}`; do
    echo ${Args[1]} $[ $i + 1 ]
    TestSame ${Args[$i]} $[ $i + 1  ] ${NumArgs}
    if [[ $? -eq 0  ]]; then
        continue
    fi
    if [[ -d ${NumArgs[$i]} ]]; then
        FindInDir ${Args[$i]}
    elif [[ -f ${Args[$i]}  ]]; then 
        FindInFile ${Args[$i]}
    else 
        continue
    fi
done

echo "${Len[0]}:${Str[0]}:${File[0]}:`grep -w ${Str[0]} -n ${File[0]} | head -n 1 | cut -d ":" -f 1`"
echo "${Len[1]}:${Str[1]}:${File[1]}:`grep -w ${Str[1]} -n ${File[1]} | head -n 1 | cut -d ":" -f 1`"
echo "${Len[2]}:${Str[2]}:${File[2]}:`grep -w ${Str[2]} -n ${File[2]} | head -n 1 | cut -d ":" -f 1`"
