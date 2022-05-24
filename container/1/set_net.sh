#!/bin/bash

# Assurera la création du bridge permettant la connexion des futurs conteneurs, vous êtes libre du type de bridge que vous allez utiliser

ovs-vsctl add-br br1
ip link set dev br1 up
