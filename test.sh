#!/bin/bash

Len=( 0 0 0 )
Str=( 0 0 0 )
File=( 0 0 0 )
ret=( 1 1 1 )

FilterConf="./filter.conf"

#$1=文件
function Filter() {
    FilterType=`basename | tr [.] "\n" | tail -1`
    grep -q -w "${FilterType}" ${FilterConf}
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    file $1 | grep -q -w "text"
    if [[ $? -eq 1 ]]; then
        return 1
    fi
    return 0
}

#$1 文件
function FindInFile() {
    Words=`cat $1 | tr -c -s "A-Za-z" "\n"`
    for i in ${Words}; do
        tmp=${#i}
        if [[ ${tmp} -gt ${Len[0]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Len[0]}
            Str[1]=${Str[0]}
            File[1]=${File[0]}
            Len[0]=${tmp}
            Str[0]=${i}
            File[0]=$1
        elif [[ ${tmp} -gt ${Len[1]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${tmp}
            Str[1]=${i}
            File[1]=$1
        elif [[ ${tmp} -gt ${Len[2]} ]]; then
            Len[2]=${tmp}
            Str[2]=${i}
            File[2]=$1
        fi
    if [[ ${Str[0]} == ${Str[1]} ]]; then
        ret[1]=2
        if [[ ${Str[1]} == ${Str[2]} ]]; then
            ret[2]=3
        fi
    fi
    if [[ ${Str[1]} == ${Str[3]} ]]; then
        ret[2]=3
    fi
    if [[ ${Str[2]} == ${Str[3]} ]]; then
        ret[2]=3
    fi
    done
}

#$1 目录
function FindInDir() {
    for i in `ls -A $1`; do
        TestSame $1/$i 0 ${NumArgs} 
        if [[ $? -eq 0 ]]; then
            continue
        fi
        if [[ -f $1/$i ]]; then
            FindInFile $1/$i 
        elif [[ -d $1/$i ]]; then
            FindInDir $1/$i 
        fi
    done
}

if [[ $# -eq 0 ]]; then
    exit
fi

for i in $*; do
    if [[ ! -e $i ]]; then
        exit
    fi
    Args+=($i)
done

#TestSame File StartSub FinishSub
function TestSame() {
    for (( x=$2; x < $3; x++ )); do
        if [[ $1 -ef  ${Args[$x]} ]]; then
            #echo "same with Args"
            return 0
        fi
    done
    return 1;
}

NumArgs=$#

for i in `echo ${!Args[@]}`; do
    TestSame ${Args[$i]} $[ $i + 1 ] ${NumArgs}
    if [[ $? -eq 0 ]]; then
        continue
    fi
    if [[ -d ${Args[$i]} ]]; then
        FindInDir ${Args[$i]}
    elif [[ -f ${Args[$i]} ]]; then
        FindInFile ${Args[$i]}
    else
        continue
    fi
done
echo "${Len[0]}:${Str[0]}:${File[0]}:`grep -w ${Str[0]} -n ${File[0]} | head -n 1 | cut -d ":" -f 1 `"
echo "${Len[1]}:${Str[1]}:${File[1]}:`grep -w ${Str[1]} -n ${File[1]} | head -n 1 | cut -d ":" -f 1 `"
echo "${Len[2]}:${Str[2]}:${File[2]}:`grep -w ${Str[2]} -n ${File[2]} | head -n 1 | cut -d ":" -f 1`"
