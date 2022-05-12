#!/bin/bash

# Installera l'ensemble des packages nécessaires à l'utilisation de conteneurs et à la création de bridge

echo installation of lxc in progress...
lxcInstall=$(apt-get install -y lxc-utils)
codeLxcInstall=$?
echo installation of ovs in progress...
ovs1Install=$(apt-get install -y openvswitch-common)
codeOvs1Install=$?
ovs2Install=$(apt-get install -y openvswitch-switch)
codeOvs2Install=$?

if [[ $codeLxcInstall == 0 ]]; then
	if [[ $lxcInstall == *"0 newly installed"* ]]; then 
		echo lxc packages already installed 
	else
		echo lxc packages installed
	fi
else 
		echo error
fi

if [[ $codeOvs1Install == 0 ]]; then
	if [[ $ovs1Install == *"0 newly installed"* ]]; then 
		echo openvswitch-common packages already installed 
	else
		echo openvswitch-common packages installed
	fi
else 
		echo error
fi

if [[ $codeOvs2Install == 0 ]]; then
	if [[ $ovs2Install == *"0 newly installed"* ]]; then 
		echo openvswitch-switch packages already installed 
	else
		echo openvswitch-switch packages installed
	fi
else 
		echo error
fi
