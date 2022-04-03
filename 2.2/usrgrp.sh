#!/bin/bash

#comprovant de que ha sigut executat com a root
if [ $EUID -ne 0 ]
then 
	echo "This script must be run as root"
	exit 1
fi

#funcio menu
function menu {

while [ "$opcion" != "s" ]
	do

	clear

	echo "###---MENU---###"
	echo " 1.Crea usuari"
	echo " 2.Crea grup"
	echo " 3.Afegeix un usuari a un grup"
	echo " 4.Treu un usuari d'un grup"
	echo " 0.Sortir del programa"
	echo "###----------###"

	read opcion
	case $opcion in

	0)
	echo "Sortint..."
	return 0
	;;

	1)
	echo "Crea usuari"
	echo "Nom de l'usuari a crear:"
	read user
	sudo adduser $user
	sleep 3
	;;

	2)
	echo "Crea grup"
	echo "Nom del grup a crear:"
	read group
	sudo groupadd $group
	sleep 3
	;;

	3)
	echo "Afegir usuari a un grup"
	echo "Nom de l'usuari:"
	read user2
	echo "Nom del grup:"
	read group2
	sudo addgroup $user2 $group2
	sleep 3
	;;

	4)
	echo "Treure un usuari d'un grup"
	echo "Nom de l'usuari:"
	read user3
	echo "Nom del grup:"
	read group3
	sudo gpasswd -d $user3 $group3
	sleep 3
	;;

	esac
	done
	return 0
}

#funcio per crear un usuari nou
function crusr {


	clear
	echo "echo ###---Creació d'un usuari nou---###"
	echo "Nom de l'usuari:"
	read user4
	echo "UID de l'usuari:"
	read Uid1
	echo "Nom del grup:"
	read group4

	sudo useradd -d /home/$user4 -s /bin/bash -u $Uid1 -g $group4 $user4
	sleep 3
	return 0;
}

#funcio per crear un grup nou
function cgrp {

	clear
	echo "echo ###---Creació d'un grup nou---###"
	echo "Nom del grup:"
	read group5
	echo "GID del grup:"
	read Gid1
	sudo addgroup --gid $Gid1 $group5
	sleep 3
	return 0	
}

#funcio per afegir un usuari a un grup
function afegr {

	clear
	echo "echo ###---Afegir usuari al grup creat anteriorment---###"
	echo "Nom de l'usuari:"
	read user6

	sudo addgroup $user6 $group5
	sleep 3
	return 0
}

#funcio d'esborrar un usuari d'un grup
function esbgr {

	clear
	echo "echo ###---Treure usuari d'un grup---###"
	echo "Nom de l'usuari:"
	read user7
	echo "Nom del grup:"
	read group7

	sudo gpasswd -d $user7 $group7
	sleep 3
	return 0	
}

#crida del menu
menu

exit 0 