#!/usr/bin/bash

get_index () {
	for i in "${!list[@]}"; do
		if [ "${list[i]}" == "${directory}" ]; then
			dnum=$i
		fi
	done
}

chmodx () {
	for dnum in "${list[@]}"; do 
		[ ! -d "$dnum" ] && chmod -x "$dnum" 
	done
}	
	
get_numdir () {
	m=0
	for i in "${list0[@]}"; do
		if [ -d "$i" ]; then
			m=$((m+1))
		fi
	done
}

unset list list0 i m k f dnum directory directory0  
f=0
directory0="$(pwd)"
IFS=$'\n\t' list0=($(echo "$(ls --group-directories-first)"))
get_numdir
IFS=$'\n\t' list=($(echo "$(ls --group-directories-first)"))
chmodx
for k in "${list0[@]}"; do
	[ -d "$k" ] && cd "$k"
	while true; do
		IFS=$'\n\t' list=($(echo "$(ls --group-directories-first)"))
		dnum=0
		while [ -d "${list[dnum]}" ]; do
			cd "${list[dnum]}"
			IFS=$'\n\t' list=($(echo "$(ls --group-directories-first)"))
		done
		chmodx
		directory=$(basename $(pwd))
		while true; do
			cd ..
			echo "pwd nach cd .. :$(pwd)"
			[ "$(pwd)" == "$directory0" ] && break
			IFS=$'\n\t' list=($(echo "$(ls --group-directories-first --ignore="lost+found")"))
			get_index
			dnum=$((dnum+1))
			if [ -d "${list[dnum]}" ]; then 
				cd "${list[dnum]}" && break
			else
				chmodx
				directory=$(basename $(pwd))
				dnum=0
			fi
		done
	[ "$(pwd)" == "$directory0" ] && break
	done
	f=$((f+1))
	((f == m)) && exit 100
done
