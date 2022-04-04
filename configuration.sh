#!/bin/bash

# Écrivez un script bash non interactif effectuant une configuration persistante d’une machine. Ce script prendra en paramètre les informations suivantes :
# • Nom à affecter à l'hôte
# • Identifiant de la carte réseau à configurer
# • Adresse de la carte réseau
# • Adresse de la passerelle
# • Adresse du DNS
# Le script réalisera les opérations suivantes :
# 1. Affectation du nom de l'hôte
# 2. Vérification de l'existence de l'interface réseau
# 3. Désactivation de la carte réseau
# 4. Modification de l'adresse de la carte réseau
# 5. Activation de l'interface réseau, et si nécessaire du service réseau
# 6. Modification de l'adresse du DNS
# 7. Test de connexion au réseau
# Des tests seront effectués à chaque étape, et une sortie d'erreur sera effectuée en cas de problème, vous différencierez les erreurs

hostname=$1
idNIC=$2
IP=$3
ipDNS=$4

changeHostname(){
	sed -i 1d /etc/hostname
	if [[ $? -ne 0 ]];
		echo Permission denied
		exit 1
	fi
	echo $hostname >> /etc/hostname
	if [[ $? == 0 ]]; then
		echo Hostname change done. It will take effect after reboot
	else
		echo error for the hostname change
		exit 1
	fi
}

checkNIC(){
	getNIC=$(ip link show $idNIC)
	if [[ $? == 1 ]]; then
		echo NIC does not exist
	else
		disableNIC
		changeIPNIC
fi
}	

disableNIC(){
	if [[ $? == 1 ]]; then
		$(ip link set dev $idNIC down)
	fi	
}


changeIPNIC(){
	oldIP=$(ip addr show dev $idNIC | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}/[0-9]{1,2}")
	$(ip addr del $oldIP dev $idNIC)
	$(ip addr add $IP dev $idNIC)
}

enableNIC(){
	$(ip link set dev $idNIC up)
}

changeDNS(){
	timestamp=$(date | cut -d ' ' -f 4)
	mv /etc/resolv.conf /etc/resolv.conf.old.$timestamp
	echo nameserver $ipDNS >> /etc/resolv.conf
}


testNET(){
	msgPING="test outside access:"
	msgDNS="test DNS:"
        
	ping -c 3 8.8.8.8 >/dev/null
        codePING=$? 

        dig google.fr >/dev/null
        codeDNS=$?

        if [[ $codePING -eq 0 ]]; then
                echo $msgPING OK
        else
                echo $msgPING KO
        fi

        if [[ $codeDNS -eq 0 ]]; then
                echo $msgDNS OK
        else
                echo $msgDNS KO
        fi

}

changeHostname
checkNIC
disableNIC
changeIPNIC
enableNIC
changeDNS
testNET
