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
groupUser=$(groups)
echo $groupUser
ownerArchive=$(stat -L -c "%U" $archive)
groupOwnerArchive=$(stat -L -c "%G" $archive)
accessRights=$(stat -L -c "%a" $archive)
#ownerArchive=$(stat -L -c "%a %G %U" $archive)
if [[ $ownerArchive == $USER || $groupOwnerArchive == *"$groupUser"* ]]; then
	if [[ $accessRights == 6** ]]; then
		echo yes
	fi
	tar xvf $archive --directory=$destinationDirectory
fi
