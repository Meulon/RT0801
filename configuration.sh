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
IP_GW=$4
IP_DNS=$5

#ens3
#sudo ip link set dev ens4 down
#sudo ip addr add 192.168.0.2/24 dev ens4
#sudo ip link set dev ens4 up
#ping google.fr

changeHostname(){
	sed -i 1d /etc/hostname
	echo $1 >> /etc/hostname
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
	$(ip addr add $IP dev $idNIC)
}

#changeHostname
checkNIC
disableNIC
