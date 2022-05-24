#!/bin/bash

# assurera l'effacement des packages installés par le script inst_cont_env.sh

apt-get remove -y lxc-utils openvswitch-common openvswitch-switch >>/dev/null
