#!/bin/bash
# Pas de paramètres
# Création d'un fichier à chaque utilisation
# Affichage et enregistrement
# de l'utilisateur
# l'id de l'utilisateur
# des groupes de l'utilisateur

ID=$(cat /etc/passwd | grep $USER | cut -d ':' -f 3)
GROUP=$(groups $USER | cut -d ' ' -f 3,4)
TIMESTAMP=$(date | cut -d ' ' -f 4)
FILENAME=$USER\_$TIMESTAMP.txt

echo Vous êtes : $USER | tee $FILENAME
echo Avec ID : $ID | tee -a $FILENAME
echo Present dans les groups : $GROUP | tee -a $FILENAME
exit 0