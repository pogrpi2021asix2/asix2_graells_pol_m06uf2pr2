#!/bin/bash
clear
case $1 in 
	-e) if (( $# != 3 )) 
		then
			echo "Numero de parametros incorrecto"
			echo "La opción -e necesita 3 parametros"
			echo "La primera opción es -e"
			echo "La segunda opción es la extensión de los ficheros a enviar a la papelera"
			echo "La tercera opción es el directorio donde se encuentran los ficheros a enviar a la papelera"
			exit 2
		fi
		if [[ ! -d ~/papelera ]]
		then
			mkdir ~/papelera
		fi
		if [[ ! -d $3 ]]
		then
			echo "La carpeta no existe"
		else
			if (( $(ls -A $3/*.$2 2> /dev/null | wc -l) != 0 ))
			# Comprueva si hay ficheros con la extensión indicada dentro del directorio. 
			# 2> /dev/null es para redireccionar avisos extras del bash.
			# 
			then
				mv $3/*.$2 ~/papelera
				echo "Los ficheros con extensión $2 de la carpeta $3 se han enviado a la papelera"
			else
				echo "Los ficheros con la extensión indicada no existen"
			fi
		 fi		 
		 ;;	 
	-r) if (( $# != 1 )) 
		then
			echo "Numero de parametros incorrecto"
			echo "La opción -r no necesita otros parámetros"
			exit 1
		fi
		if [[ ! -d ~/papelera ]]
		then
			echo "La papelera aun no existe"
		else
			if (( $(ls -A ~/papelera | wc -l) != 0 ))
			then
				rm ~/papelera/* 
				echo "Papelera vacía"
			else
				echo "La papelera ya esta vacía" 
			fi
		fi
		;;	
	
esac

exit 0