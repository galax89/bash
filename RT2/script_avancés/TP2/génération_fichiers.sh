#!/bin/bash
chmod a+x ./génération_fichiers.sh

i=0
for i in $(seq 1 25)
do
  $(dd if=/dev/urandom of=/tmp/fichier$i.tmp bs=1M count=10 1>/dev/null 2>/dev/null)
done
# ls /tmp | grep -e 'fichier*.tmp' || echo "Nope.avi"
