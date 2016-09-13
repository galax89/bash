#!/bin/bash
chmod 755 ./explorateur.sh

#stock de la liste détaillée des fichiers dans un fichier temporaire effacé à la fin du script
ls -l > /tmp/liste.ls
#On supprime la première ligne
# sed -i '1d' /tmp/liste.ls

#lecture de la liste
cat resultats.ls |
while read line
do
	# On récupère les informations à afficher: nom du fichier, owner, user loggé, type
	nom=$(echo $line | cut -d" " -f9)
	# pas besoin du propriétaire
	# owner=$(echo $line | cut -d" " -f3)
	user=$(whoami)
	# La commande file renvoi une phrase, on va juste récupérer le type dans une variable
	commande_file=$(file $nom 2>/dev/null)
	typ=$(echo $commande_file | cut -d":" -f2 2>/dev/null)
	# chmod contient l'affichage des droits + type du fichier
	chmod=$(echo $line | cut -d" " -f1)
	# On extrapole les droits de l'utilisateur loggé $droits
	droits=$(echo $chmod | cut -c2-4)
	dossier=$(echo $chmod | cut -c1)

	#On déclare un  tableau associatif, on va s'en servir comme d'un tableau à 2 dimensions. Droits possibles + affichage en français
	declare -A tableau_droits
	tableau_droits=([---]='rien du tout pour vous, dommage ...' [--x]='éxécution' [-w-]='écriture' [-wx]='écriture et éxécution' [r--]='lecture' [r-x]='lecture et éxécution' [rw-]='lecture et écriture' [rwx]='lecture, écriture et éxecution')

	# Repère visuel, l'option -e prend en compte les caractères scpéciaux (retour chariot)
	echo -e "\n-------------------------------------------------------------------------"
	if [ "$dossier" == '-' ]; then
		echo "Le fichier \"$nom\" est un fichier $typ"
	else
		echo "Le fichier \"$nom\" est un répertoire"
	fi
	echo "\"$nom\" est accessible par \"$user\" avec les droits d'accès en ${tableau_droits[$droits]}"
	#Youpi !

	done

#-------------------------------

rm /tmp/liste.ls
# sleep 4
# clear
