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

createDummyNIC(){
	ip link show qsd &>/dev/null
	if [[ $? == 1 ]]; then
		ip link add qsd type dummy
		echo interface qsd created
	else
		echo interface already created
	fi 
}

checkHostname(){
	currentHostname=$(cat /etc/hostname)
	if [[ $currentHostname == $hostname ]]; then
		echo no hostname change because this is the same hostname
		exit 1
	fi
}

changeHostname(){
	sed -i 1d /etc/hostname &>/dev/null
	if [[ $? -ne 0 ]]; then
		echo Permission denied
		exit 1
	else	
		echo $hostname >> /etc/hostname
		if [[ $? == 0 ]]; then
			echo Hostname change done. It will take effect after reboot
		else
			echo error for the hostname change
			exit 1
		fi
	fi
}

checkNIC(){
	ip link show $idNIC &>/dev/null
	if [[ $? == 1 ]]; then
		echo NIC does not exist
		exit 1
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
	msgPINGSuccess="test outside access: OK"
	msgDNSSuccess="test DNS: OK"
	msgPINGError="test outside access: NOK"
	msgDNSError="test DNS: NOK"
        
	ping -c 3 8.8.8.8 >/dev/null
        codePING=$? 

        dig google.fr >/dev/null
        codeDNS=$?

        if [[ $codePING -eq 0 ]]; then
                echo $msgPINGSuccess
        else
                echo $msgPINGError
        fi

        if [[ $codeDNS -eq 0 ]]; then
                echo $msgDNSSuccess
        else
                echo $msgDNSError
        fi

}

if [[ $# -lt 4 ]]; then
	echo "arguments required : hostname, idNIC, IP, ipDNS"
	echo example: tata qsd 192.168.1.24 8.8.8.8
	exit 1
else
	createDummyNIC
	checkHostname
	changeHostname
	checkNIC      
	disableNIC    
	changeIPNIC   
	enableNIC     
	changeDNS     
	testNET
fi	
