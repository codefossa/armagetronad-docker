#!/bin/bash
loc="/app/server"
tron="${loc}/bin/armagetronad-dedicated"
userdatadir="${loc}/server"
vardir="${userdatadir}/var"
userconfigdir="${userdatadir}/settings"
resourcedir="${userdatadir}/resource"
consolelog="${vardir}/consolelog.txt"
input="${vardir}/input.txt"

# Create user.
if ! id "${UID}" &>/dev/null && [[ "${UID}" =~ ^[0-9]+$ ]]; then
	echo "Creating new user: ${UID}"
	useradd -m -u $UID tronuser
fi

user=$(id -un $UID)

if [[ "${GID}" =~ ^[0-9]+$ ]]; then
	echo "Adding user to group: ${GID}"
	usermod -aG $GID $user
fi

# Run the arma server.
echo "Running as user: ${user}"

while true;
do
	sudo -u $user $tron --resourcedir $resourcedir --userconfigdir $userconfigdir --vardir $vardir --userdatadir $userdatadir"/" --input $input > $consolelog
done &

# Display the console log in container logs.
tail -f $consolelog
