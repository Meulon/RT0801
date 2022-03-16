#!/bin/bash
# Plusieurs paramètres
# nom archive ($1)
# nom du repertoire à sauvegarder ($2)
# adresse du serveur de sauvegarde + chemin : adresse:chemin ($4) 
# login et password du compte ($3)
# archive réalisée avec tar
# copie à travers du réseau de l'archive

tar -cvf $1 $2
scp $1 $3:$4@$5
test
exit 0
