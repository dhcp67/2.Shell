#!/bin/bash


Len=( 0 0 0 )
Str=( 0 0 0 )
File=( 0 0 0 )
Filterconf="./filter.conf"

#$1=wenjian a.txt  a.a.txt  ./a/b/a.txt
function Filter() {
    filterType=`basename | tr [.] "\n" | tail -1`
    grep -q -w "${filterType}" ${Filterconf}
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    file $1 | grep -q -w "text"
    if [[ $? -eq 1 ]]; then 
        return 1
    fi
    return 0
}


#$1  文件
function FindInfile() {
    Words=`cat $1 | tr -c -s "A-Za-z" "\n"`
    for i in ${Words}; do
        Tmp=${#i}
        if [[ ${Tmp} -ge ${Len[0]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Len[0]}
            Str[1]=${Str[0]}
            File[1]=${file[0]}
            Len[0]=${Tmp}
            Str[0]=${i}
            file[0]=$1
        elif [[ ${Tmp} -ge ${Len[1]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Tmp}
            Str[1]=${i}
            file[1]=$1
        else [[ ${Tmp} -ge ${Len[2]} ]]
            Len[2]=${Tmp}
            Str[2]=${i}
            File[2]=$1
        fi
    done
}

#$1 目录
function findInDir() {
    for i in `ls -A`; do
        TestSame $1/$i 
        if [[ -f $1/$i ]]; then
            FindInfile $1/$i
        elif [[ -d $1/$i ]]; then
            FindInfile $1/$i 
        else
            return
        fi
    done
}

for i in `$@`; do
    if [[! -e $i ]]; then
        exit
    fi 
    Args+=($i)
done

#TestSame File StartSub FinishSub
function TestSame() {
    for (( x=$2; x<$3; x++ )); do
        if [[ $1 -ef ${Args[$x]} ]]; then
            echo "Same with Args"
            return 0
        fi 
    done
    return 1
}

NumArgs=$#

for i in `echo ${!Args[@]}`; do
    TestSame ${Args[$i]} $[ $i + 1 ] ${numArgs} 
    if [[ $? -eq 0 ]]; then
        continue
    fi 
    if [[ -d ${Args[$i]} ]]; then 
        findInDir ${Args[$i]}
    elif [[ -f ${args[$i]} ]]; then 
        FindInfile ${Args[$i]}
    else 
        continue
    fi 
done

echo "${Len[0]}:${Str[0]}:${File[0]}:`grep -w ${Str[0]} ${File[0]} |head -n 1 | cut -d ":" -f 1`"
echo "${Len[1]}:${Str[1]}:${File[1]}:`grep -w ${Str[0]} ${File[0]} |head -n 1 | cut -d ":" -f 1`"
echo "${Len[2]}:${Str[2]}:${File[2]}:`grep -w ${Str[0]} ${File[0]} |head -n 1 | cut -d ":" -f 1`"
