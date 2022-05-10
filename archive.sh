#!/bin/bash
# Plusieurs paramètres
# nom archive ($1)
# nom du repertoire à sauvegarder ($2)
# adresse du serveur de sauvegarde + chemin : adresse:chemin ($4)
# login et password du compte ($3)
# archive réalisée avec tar
# copie à travers du réseau de l'archive

file=$1
archive=$2
server=$3
login=$4
password=$5

archiveFile(){
        tar -cvf $archive $file
}

transfertArchive(){
        sshpass -p $password sftp -oBatchMode=no -b - $login@$server << !
        put $archive
        bye
!
}

if [[ $# -lt 5 ]]; then
        echo "ERROR: arguments missing"
        echo "arguments expected: directory, archiveName, server IP, login, password"
        echo "example: directoryToArchive archiveName 172.19.128.210 toto tata"
        exit 1
elif [[ $# -gt 5 ]]; then
        echo "ERROR: too much arguments"
        echo "arguments expected: directory, archiveName, server IP, login, password"
        echo "example: directoryToArchive archiveName 172.19.128.210 toto tata"
        exit 1
else
        archiveFile >/dev/null
        transfertArchive >/dev/null
fi
