#!/bin/bash
# Pas de paramètres
# Création d'un fichier à chaque utilisation
# Affichage et enregistrement
# de l'utilisateur
# l'id de l'utilisateur
# des groupes de l'utilisateur


ID=$(cat /etc/passwd | grep $USER | cut -d ':' -f 3 >> ./test.txt)
echo $ID