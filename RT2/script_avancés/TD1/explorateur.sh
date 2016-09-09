#!/bin/bash
chmod 755 ./explorateur.sh

#stock de la liste détaillée des fichiers
ls -l >> /tmp/liste.ls

#lecture de la liste
cat resultats.ls |
while read line
do
	# On récupère les informations à afficher: nom du fichier, owner, user loggé, type
	nom=$(echo $line | cut -d" " -f9)
	# owner=$(echo $line | cut -d" " -f3)
	user=$(whoami)
	commande_file=$(file $nom 2>/dev/null)
	typ=$(echo $commande_file | cut -d":" -f2 2>/dev/null)
	# chmod contient l'affichage des droits + type du fichier
	chmod=$(echo $line | cut -d" " -f1)
	# On extrapole les droits de l'utilisateur dabs $droits
	droits=$(echo $chmod | cut -c2-4)
	dossier=$(echo $chmod | cut -c1)
	tableau_droits=('---' '--x' '-w-' '-wx' 'r--' 'r-x' 'rw-' 'rwx')
	tableau_droits_fr=('rien du tout pour vous, dommage ...' 'éxécution' 'écriture' 'écriture et éxécution' 'lecture et écriture' 'lecture, écriture et éxecution')

	echo -e "\n-------------------------------------------------------------------------"
	if [ "$dossier" == '-' ]; then
		echo "Le fichier \"$nom\" est un fichier $typ"
	else
		echo "Le fichier \"$nom\" est un répertoire"
	fi

	# A finir affichage droits
	# Manque comparaison deux chaine char
	i=0
	element=('')
	for i in $(seq 0 7)
	do
		echo "$i $droits"
		for element in ${tableau_droits[@]}
		do
			if [$droits = ${tableau_droits[i]}]; then
				echo "$droits $tableau_droits"
				# echo \n "\"$nom\" est accessible par \"$user\" avec les droits d'accès en ${tableau_droits_fr[i]}"
			fi
		done
	done
done

#-------------------------------

rm /tmp/liste.ls
# sleep 4
