#!/bin/sh
###
# Keep-MEGA-Alive v1.2
##########################

exec 4>>~/keep-mega-alive.log

LOGINS=${1:-"mega-logins.csv"}

log_msg () {
	msg=$1
	echo "$(date +"%Y-%m-%dT%H:%M:%S%:z") : $msg" >&4
}

if ! [ -x "$(command -v mega-version)" ]; then
	echo 'Error: MEGAcmd is not installed. Get it from https://mega.io/cmd' >&2
	exit 1
fi

log_msg "Starting keep-mega-alive" 

mega-logout 1>/dev/null

IFS=","
while read username password
do
	echo "\n>>> $username"
	log_msg "Trying to login as $username"
	
	mega-login "$username" "$password" >&4

	if [ ! $? -eq  0 ]
	then 
		echo "Unable to login as $username"
		log_msg "[ERROR] Unable to login as $username"
		continue  
	fi

	log_msg "Successfully logged in as $username"
	
	mega-df -h
	log_msg "Successfully wrote disk usage"
	
	mega-logout 1>/dev/null
	log_msg "Logged out from $username \n"

done <$LOGINS

log_msg "Finished running keep-mega-alive \n"

exec 4>&-