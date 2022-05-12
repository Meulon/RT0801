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
echo $accessRights
ownerAccessRights=${accessRights:0:1}
groupAccessRights=${accessRights:1:1}
othersAccessRights=${accessRights:2:1}
echo $ownerAccessRights
echo $groupAccessRights
echo $othersAccessRights
#ownerArchive=$(stat -L -c "%a %G %U" $archive)
if [[ $ownerArchive == $USER &&	$ownerAccessRights -ge 4 ]]; then
	tar xvf $archive --directory=$destinationDirectory
elif [[ $groupOwnerArchive == *"$groupUser"* && $groupAccessRights -ge 4 ]]; then
	tar xvf $archive --directory=$destinationDirectory
elif [[ $othersAccessRights -ge 4 ]]; then
	tar xvf $archive --directory=$destinationDirectory
else
	echo no permission to unarchive
fi
