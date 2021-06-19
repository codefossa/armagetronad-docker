#!/bin/bash
loc="/app/server"
tron="${loc}/bin/armagetronad-dedicated"
userdatadir="${loc}/server"
vardir="${userdatadir}/var"
userconfigdir="${userdatadir}/settings"
resourcedir="${userdatadir}/resource"
consolelog="${vardir}/consolelog.txt"

while true;
do
	$tron --resourcedir $resourcedir --userconfigdir $userconfigdir --vardir $vardir --userdatadir $userdatadir"/" > $consolelog
done
