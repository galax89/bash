#!/bin/bash
chmod a+x explorateur_processus.sh
#
#fichier .dot
tab=./explorateur_processus.dot
#
# Récupération : nom, pid, ppid, pourcentage mem utilisée, trié par pid
ps xao comm,pid,ppid,%mem,rss --sort -pid | tr -s " " > /tmp/resultats.ps
#
# Supprimer 1 ère ligne (attributs des colonnes)
sed -i 1d /tmp/resultats.ps
#
#
echo -e "digraph explorateur_processus {\n\t" > $tab
# On lit le fichier contenant le résultat de ps et on récupère les données
cat /tmp/resultats.ps |
while read line
do
  nom=$(echo $line | cut -d" " -f1)
  num_PID=$(echo $line | cut -d" " -f2)
  num_PPID=$(echo $line | cut -d" " -f3)
  mem=$(echo $line | cut -d" " -f4)
#
# Vérification existence de PID et PPID
  if [ -n $num_PID -a -n $num_PPID ]
  then
# On affiche les liens du PPID à PID. Entre []: paramètres de l'affichage
    echo -e "\t$num_PPID -> $num_PID;\n" >> $tab
    echo -e "\t$num_PID[label="\"$num_PID\\n$nom\"",shape="box",color="blue",height="$mem",width="$mem"];" >> $tab
  fi
done
#
echo '}' >> $tab
#
# Création de l'image
dot explorateur_processus.dot -Tpng -oexplorateur_processus.png
