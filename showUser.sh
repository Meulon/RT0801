#!/bin/bash

#VARIABLES

GROUP=$(groups)
ID=$(cat /etc/passwd | grep $USER | cut -d ':' -f 3)

showUser(){
	echo USER: $USER 
	echo ID: $ID
	echo GROUPS: $GROUP
}

exportToFile(){
	pwd=$(pwd)
	version=1
	filename=$USER\_INFO_V$version.txt
	while [[ -e $filename ]]
	do
		let version++
		filename=$USER\_INFO_V$version.txt
	done
	showUser > $filename
	echo recap created here: $pwd
}

showUser
exportToFile

exit 0
