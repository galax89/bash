#!/bin/bash
chmod 755 explorateur.sh

ls -l >> resultats.ls
#stock arborescence
cat resultats.ls |
while read line
do
	#récup, nom fichier, owner, type
	#rep=$(echo $line | cut -s -f1)
	nom=$(echo $line | cut -d" " -f9)
	user=$(echo $line | cut -d" " -f3)
	com_file=$(file $nom 2>/dev/null)
	typ=$(echo $com_file | cut -d":" -f2 2>/dev/null)

	droit=$(echo $line | cut -d" " -f1)
	dossier=$(echo $droit | cut -c1)


	echo "---------"
	if [ "$dossier" == '-' ]; then
		echo "Le fichier $nom est un fichier $typ"
	else
		echo "Le fichier $nom est un repertoire"
	fi
	echo "$nom est accessible par $user avec les droits $droit"

done

#-------------------------------

rm resultats.ls
sleep 4
