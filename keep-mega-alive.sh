#!/bin/sh
###
# Keep-MEGA-Alive v1.2
##########################

exec 4>>~/keep-mega-alive.log

LOGINS=${1:-"mega-logins.csv"}

if ! [ -x "$(command -v mega-version)" ]; then
	echo 'Error: MEGAcmd is not installed. Get it from https://mega.io/cmd' >&2
	exit 1
fi

echo -e "$(date "+%m%d%Y %T") : Starting keep-mega-alive \n" >&4

mega-logout 1>/dev/null

IFS=","
while read username password
do
	echo -e "\n>>> $username"
	echo "$(date "+%m%d%Y %T") : Trying to login as $username" >&4
	
	mega-login "$username" "$password"

	if [ ! $? -eq  0 ]
	then 
		echo "Unable to login as $username"
		echo -e "$(date "+%m%d%Y %T") : [ERROR] Unable to login as $username \n" >&4
		continue  
	fi

	echo "$(date "+%m%d%Y %T") : Successfully logged in as $username" >&4
	
	mega-df -h 
	echo "$(date "+%m%d%Y %T") : Successfully wrote disk usage " >&4
	
	mega-logout 1>/dev/null
	echo -e "$(date "+%m%d%Y %T") : Logged out \n" >&4

done <$LOGINS

echo -e "$(date "+%m%d%Y %T") : Finished running keep-mega-alive \n" >&4

exec 4>&-