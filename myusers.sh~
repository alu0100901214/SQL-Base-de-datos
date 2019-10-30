#!/bin/bash

	# Variables
  
  contador=
  grupo=
  shell=
  USER_NAME=
  COUNT_G=
	# Funciones
  
	# Información del uso

  usage(){
  echo "usage: myusers.sh [[ -u user1 user2 ... user(n) ] | [ -n user1 user2 ... user(n) ] | [ -h ]]"
  }

	# Salida de error
  error_exit(){
  echo "${PROGNAME}: ${1:-"Error desconocido"}" 1>&2
  exit 1
  }
	#Determina a que grupo pertenece

  group(){
  n=1
  for k in $(getent passwd | sort | awk -F ":" '{print $1}' | uniq); do
  if [ "$1" == "$k" ]; then
  grupo=$(getent passwd | sort | awk -F ":" '{print $3}' | uniq | sed -n $n"p")
  
  if [ $grupo == 0 ]; then
  printf "Es el root\t"
  fi
  
  if [ $grupo -ge 1 ] && [ $grupo -le 99 ]; then
  printf "Es un usuario predefinido\t"
  fi
  
  if [ $grupo -ge 100 ] && [ $grupo -le 999 ]; then
  printf "Es un usuario administrador\t"
  fi
  
  if [ $grupo -ge 1000 ]; then
  printf "Es un usuario normal\t"
  fi
  
  fi

  n=$((n + 1))
  done
  }
	
	#Comprueba si el arranque de la shell es valida

  valid_shell(){
  n=1
  for k in $(getent passwd | sort | awk -F ":" '{print $1}' | uniq); do
  if [ "$1" == "$k" ]; then
  shell=$(getent passwd | sort | awk -F ":" '{print $7}' | sed -n $n"p")
  if [ "$shell" == "/bin/false" ] || [ "$shell" == "/usr/sbin/nologin" ]; then
  printf "Es un usuario interno\n"
  else
  printf "El usuario tiene una shell de arranque válida\n"
  fi
  fi
  n=$((n + 1))
  done
  }
  
  
	# Buscar uno o varios usuarios en concreto

  search_user(){
  for i in $(ps -A -ouser --no-headers | sort | uniq); do

  if [ "$i" == "$1" ]; then

  for j in $(ps -A -ouser --no-headers | sort); do
  
  if [ "$i" == "$j" ]; then
  contador=$((contador + 1))
  fi

  done
  printf "$i  $contador  "
  group $i
  valid_shell $i
  contador=0
  
  fi
  done
  if [ "$1" == "-n" ]; then
  error_exit "$LINENO: Error, No puedes usar mas comandos despues de -u"
  fi
  }

	# Mostrar todos los usuarios menos uno  o varios usuarios en concreto

  search_no_user(){
  a=0
  printf "USER\t\tNº PROCESOS\tTIPO DE USUARIO\tTIPO DE SHELL\n"
  for i in $(ps -A -ouser --no-headers | sort | uniq); do
  if [ a != 1 ]; then
  if [ "$i" != "$1" ]; then

  for j in $(ps -A -ouser --no-headers | sort); do
  if [ "$i" == "$j" ]; then
  contador=$((contador + 1))
  fi
  done
  printf "$i  $contador  "
  group $i
  valid_shell $i
  contador=0
  COUNT_G=$((COUNT_G + 1))
  else
  a=1
  COUNT_G=$((COUNT_G + 1))
  fi
  fi
  done
  }

	# Lista de usuarios con algun programa ejecutado

  user_list(){
  printf "USER\t\tNº PROCESOS\tTIPO DE USUARIO\tTIPO DE SHELL\n"
  for i in $(ps -A -ouser --no-headers | sort | uniq); do
  for j in $(ps -A -ouser --no-headers | sort ); do
  if [ "$i" == "$j" ];then
  contador=$((contador + 1))
  fi
  done
  # if??
  printf "%s\t\t%d\t\t  " $i $contador
  group $i
  valid_shell $i
  contador=0
  done
  user_home $USER
  }

  user_home(){
  for i in $(ps -A -ouser --no-headers | sort | uniq); do
  for j in $(ps -A -ouser --no-headers | sort ); do
  if [ "$i" == "$j" ];then
  contador=$((contador + 1))
  fi
  done
  if [ "$i" == "$1" ]; then
  printf "%s\t%d\t" $i $contador
  fi
  
  done
  grupo=$(getent passwd alu0100901214 | sort | awk -F ":" '{print $3}')
  if [ $grupo == 0 ]; then
  printf "Es el root\t"
  fi
  
  if [ $grupo -ge 1 ] && [ $grupo -le 99 ]; then
  printf "Es un usuario predefinido\t"
  fi
  
  if [ $grupo -ge 100 ] && [ $grupo -le 999 ]; then
  printf "Es un usuario administrador\t"
  fi
  
  if [ $grupo -ge 1000 ]; then
  printf "Es un usuario normal\t"
  fi

  shell=$(getent passwd alu0100901214 | sort | awk -F ":" '{print $7}')
  if [ "$shell" == "/bin/false" ] || [ "$shell" == "/usr/sbin/nologin" ]; then
  printf "Es un usuario interno"
  else
  printf "El usuario tiene una shell de arranque válida"
  fi
  hom=$(getent passwd alu0100901214 | sort | awk -F ":" '{print $6}')
  printf "\t%s\n" $hom
  }
	# Programa principal
  
  while [ "$1" != "" ]; do
  lista=1
  case $1 in
  -u ) # Opcion para buscar uno o varios usuarios
  printf "USER\t\tNº PROCESOS\tTIPO DE USUARIO\tTIPO DE SHELL\n"
  shift
  while [ "$1" != "" ]; do
  search_user $1
  shift
  done
  ;;
  -n ) # Opcion para imprimir la lista menos uno o varios usuarios
  shift
  printf "USER\t\tNº PROCESOS\tTIPO DE USUARIO\tTIPO DE SHELL\n"
  for i in $(ps -aux | sort | cut -d " " -f 1 | uniq); do
  if [ "$i" != "$1" ]; then
  for j in $(ps -aux | sort | cut -d " " -f 1); do
  if [ "$i" == "$j" ]; then
  contador=$((contador + 1))
  fi
  done
  printf "$i  $contador  "
  group $i
  valid_shell $i
  contador=0
  else
  shift
  fi
  done
  if [ "$1" == "-u" ]; then
  error_exit "$LINENO: Error, No puedes usar mas comandos despues de -n"
  fi
  ;;  
  -h )   usage
  exit 0;;
  
  * )    usage
  	 error_exit "$LINENO: Error, el comando $1 no esta soportado "
 	 exit 1
  esac
  shift
  done
  
  if [ "$lista" != "1" ]; then
  user_list
  fi
	
	# FINAL DEL SCRIPT


