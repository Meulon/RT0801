#!/bin/bash

# assurera la destruction du bridge créé par le script set_net.sh, ainsi que la remise en place de la configuration d'origine

ovs-vsctl del-br br1
