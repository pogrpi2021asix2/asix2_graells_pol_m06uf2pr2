#!/bin/bash
clear

if (( EUID != 0 ))
then
  echo "Este script se tiene que ejecutar con root"
  exit 9
fi
echo "Creación de usuarios"
echo
echo -n "Cuantos usuarios quieres crear entre 1 i 30: "
read n_usr
if (( $n_usr < 1 )) || (( $n_usr > 30 ))
then
	echo "Numero incorrecto"
	exit 1
fi
echo -n "Que nombre base quieres: "
read nom_base
echo -n "Que UID quieres para los usuarios creados: "
read uid

echo "Lista De usuarios" > /root/$nom_base
if (( $? != 0 ))
	then
		echo "Problema creando el fichero "
		exit 3
	fi
echo "Formato de la lista: Nombre de usuario  Contrasenya  UID" >> /root/$nom_base  

for (( num=1; num<=$n_usr; num++ )) 
do
	ctsnya=$(pwgen 10 1)
	nom_usr=$nom_base$num.clot
	echo "$nom_usr  $ctsnya  $uid" >> /root/$nom_base
	useradd $nom_base$num.clot -u $uid -g users -d /home/$nom_base$num.clot -m -s /bin/bash -p $(mkpasswd $ctsnya)
	if (( $? != 0 ))
	then
		echo "Problema creando los usuarios"
		exit 2
	fi
	(( uid++ ))   
done 

exit 0