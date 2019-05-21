#!/bin/bash
Max=0
MaxString=0

function Fliter() {
	FliterFile=$1
    file ${FliterFile} | grep -q -w "text"
	if [[ $? -eq 0 ]]; then
		echo 0
	else
		echo 1
	fi
}


function FindFile() {
	local File=$1
	for i in `cat ${File} | tr -c -s "A-Za-z" "\n"`; do
		echo $i
		if [[ ${Max} -lt ${#i} ]]; then
			Max=${#i}
			MaxString=${i}
		fi
	done
}


function FindDir() {
	local DirName=$1
	for i in `ls -A ${DirName}`; do
		if [[ -d ${DirName}/${i} ]]; then
			FindDir ${DirName}/${i}
		elif [[ -f ${DirName}/${i} ]]; then
			Check=`Fliter ${DirName}/${i}`
			if [[ ${Check} -eq 0 ]]; then
				FindFile ${DirName}/${i}
			fi
		fi
	done
}


w=$#
echo $w
for (( i = 1; i < w; i++ ));do
if [[  -d $i ]]; then
	FindDir $i
elif [[ -f $i ]]; then
	Check=`FliterFile $i`
	if [[ ${Check} -eq 0 ]]; then
		FindFile $i
	fi
fi

printf "MaxString=%s, Max=%d\n" ${MaxString} ${Max}
done
