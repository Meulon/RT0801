#!/bin/bash

# Description du script
# • Paramètres
# o le nom de l’archive
# o le répertoire de base d’installation 
# • Opérations
# o Vérification des existences et des droits
# o Test du type d’archive (zip, tar, tgz) (Uniquement sur l’extension) 
# o Utilisation de l’archiveur correspondant

archive=$1
destinationDirectory=$2

tar xvf $archive --directory=$destinationDirectory
