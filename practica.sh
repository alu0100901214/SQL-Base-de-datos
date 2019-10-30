

#!/bin/bash

# 

# CONSTANTES

count=
userid=

#Funciones

funcion(){

printf "%10s %14s\n" "Usuario" "Nº procesos"
printf "%22s\n" "abiertos"
for j in $(ps -aux | cut -d " " -f 1 | sort | uniq); do
	for i in $(ps -aux | cut -d " " -f 1 | sort); do
		if [ "$i" == "$j" ]; then
			count=$((count + 1))
		fi
	


done
	for k in $(getent passwd | awk -F ":" $1 | sort); do

		if [[ "$k" == "$j" ]]; then
			if [[ "$3" == "0" ]]; then
				userid="root"
			#printf "%10s %8d %10s\n" $j $count $userid
			fi
			if [ "$3" -ge "1" ] && [ "$3" -le "99" ]; then
				userid="usuario predefinido"
			#printf "%10s %8d %10s\n" $j $count $userid
			fi
			if [ "$3" -ge "100" ] && [ "$3" -le "999" ]; then
				userid="usuario administradores"
			#printf "%10s %8d %10s\n" $j $count $userid
			fi
			if [ "$3" -ge "1000" ]; then
				userid="usuario normal"
			#printf "%10s %8d %10s\n" $j $count $userid
			fi
			
		fi
		
	done
	printf "%10s %8d %10s\n" $j $count $userid
	count=0

done

}

usage(){
echo "usage: sysinfo_page [[[ -f file ] [-i]] | [-h] | [-p] | [-b]]"
}

error_exit(){
	echo "${PROGNAME}: ${1:-"Error desconocido"}" 1>&2
	exit 1
}

# ps -aux | cut -d " " -f 1 | sort | uniq

#Programa principal

funcion



