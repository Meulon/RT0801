#!/bin/bash
# Pas de paramètres
# Création d'un fichier à chaque utilisation
# Affichage et enregistrement
# de l'utilisateur
# l'id de l'utilisateur
# des groupes de l'utilisateur


ID=$(cat /etc/passwd | grep $USER | cut -d ':' -f 3)
GROUP=$(groups $USER | cut -d ' ' -f 3,4)

echo Vous êtes : $USER
echo Avec ID : $ID
echo Present dans les groups : $GROUPS
exit 0