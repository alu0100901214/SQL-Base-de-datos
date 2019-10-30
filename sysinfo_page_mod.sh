#!/bin/bash

	# sysinfo_page - Un script que produce un archivo HTML

	# CONSTANTES

  TITLE="Informacion de mi sistema para $HOSTNAME"
  RIGHT_NOW=$(date +"%x %r %Z")
  TIME_STAMP="Actualizada el $RIGHT_NOW por $USER"
  interactive=
  back=
  filtro=""
  filename=~/sysinfo_page.html

	#FUNCIONES

	# información del uso

  usage(){
  echo "usage: sysinfo_page [[[ -f file ] [-i]] | [-h] | [-p] | [-b]]"
  }

	#Muestra informacion de la version del sistema
  system_info(){
  echo "<h2>Informacion de la versión del sistema</h2>"
  echo "<p>Funcion no implementada</p>"
  }

	#Muestra el comando uptime

  show_uptime(){
  echo "<h2>Tiempo de encendido del sistema</h2>"
  echo "<pre>"
  uptime
  echo "</pre>"
  }
	#Muestra el comando df

  drive_space(){
  echo "<h2>Espacio en el sistema de archivos</h2>"
  echo "<pre>"
  if [ "$filtro" != "" ]; then
  df | cut -d " " -f 1 | grep "$filtro"
  else
  df
  fi
  echo "</pre>"
  }

	#Solo el superusuario puede obtener la informacion
  
  home_space(){
  suma=0
  num_dir=
  if [ "$(id -u)" = "0" ]; then
  for i in $(du -s $HOME | cut -f 1); do
	count=$((count + 1))
	suma=$(( $suma + $i ))
  done
  num_file=$(ls $HOME | wc -l)
  num_dir=$(find $HOME -type d | wc -l)
  num_ex=$(find . -executable | wc -l)
  #num_no_ex=$(( $num_file - $num_ex ))
	echo "<h2>Espacio en directorio personal por usuario</h2>"
	echo "<pre>"
	echo "Bytes Directorio"
	du -s /home/* | sort -nr
	printf "DIRECTORIOS\tARCHIVOS\tEJECUTABLES\tNO EJECUTABLES\tUSADO\tDIRECTORIO\n%d\t%d\t%d\t%d\t%d\t%s\n" $num_dir $num_file $num_ex $(($num_file - $num_ex)) $suma "$HOME"
	echo "</pre>"
  else
  for i in $(du -s $HOME | cut -f 1); do
	count=$((count + 1))
	suma=$(( $suma + $i ))
  done
  num_file=$(ls $HOME | wc -l)
  num_dir=$(find $HOME -type d | wc -l)
  num_ex=$(find . -executable | wc -l)
  #num_no_ex=$(( $num_file - $num_ex ))
	echo "<h2>Espacio en directorio personal por usuario</h2>"
	echo "<pre>"
	echo "Bytes Directorio"
	du -s $HOME | sort -nr
	printf "DIRECTORIOS\tARCHIVOS\tEJECUTABLES\tNO EJECUTABLES\tUSADO\tDIRECTORIO\n%d\t%d\t%d\t%d\t%d\t%s\n" $num_dir $num_file $num_ex $(($num_file - $num_ex)) $suma "$HOME"
	echo "</pre>"

  fi
  }
	#Devuelve la salida en el archivo indicado

fil(){
cat << _EOF_
<html>
<head>
  <title>
  $TITLE
  </title>
</head>

<body>
  <h1>$TITLE</h1>
  <p>$TIME_STAMP</p>
  $(system_info)
  $(show_uptime)
  $(drive_space)
  $(home_space)
  $(open_files)
</body>
</html>
_EOF_
}

	#modo interactivo

  interac(){
  archivo=
  option=
  numero_max= ls | wc -l
  i=0
  if [ $interactive -eq 1 ]; then
  echo "Introduce el nombre del archivo: "
  read archivo
  comprobar=$(find $archivo)

  if [ "$archivo" == "$comprobar" ]; then
	echo "Hay un archivo igual, desea sobreescribirlo? (s(si)/n(no)): "
	read $option
	if [ "$option" == "s" ]; then
	fil > $archivo
	filename=$archivo
	echo $(fil) > $archivo
	else
	exit 1
	fi
  else
  filename=$archivo
  fil > $archivo
  echo $(fil) > $archivo
  echo el archivo se ha creado con exito
  fi
  fi
  }

	# Muestra un mensaje de error

  error_exit(){
	echo "${PROGNAME}: ${1:-"Error desconocido"}" 1>&2
	exit 1
  }

	# Indica el número de archivos abiertos por cada usuario

  open_files(){
  usuario=
  echo "<h2> Numero de archivos abiertos</h2>"
  echo "<pre>"
  echo "USUARIO NUMERO ARCHIVOS"
  for i in $(who | cut -d " " -f 1 | sort | uniq); do
  echo "$i $(lsof -u $i | wc -l)"
  done

  echo "</pre>"
  }

		#PROGRAMA PRINCIPAL

  if  test -x $(which df); then
  echo "El comando df existe y es ejecutable"
  else
  error_exit " Error, el comando df no existe y/o no es ejecutable"
  fi

  if  test -x $(which du); then
  echo "El comando du existe y es ejecutable"
  else
  error_exit " Error, el comando df no existe y/o no es ejecutable"
  fi

  if  test -x $(which uptime); then
  echo "El comando uptime existe y es ejecutable"
  else
  error_exit " Error, el comando df no existe y/o no es ejecutable"
  fi

  while [ "$1" != "" ]; do
  case $1 in
	-f | --file ) 	shift
			filename=$1
			;;
	-i | --interactive )  interactive=1
			      ;;
	-h | --help ) 	usage
			exit;;
	-p | --partitions-filter )   shift
				     filtro=$1
			;;
	-b | --backup )	back=1
	;;
	* ) 		usage
			error_exit " Error, el comando $1 no esta soportado"
			exit 1
	esac
	shift
	done


  if [ "$back" = "1" ]; then
  fil > $filename.bak
  interactive=0
  fi

  if [ "$interactive" = "1" ]; then
	interac
  fi

  fil > $filename

	# FINAL DEL SCRIPT




