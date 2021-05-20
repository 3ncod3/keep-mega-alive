#!/bin/sh
###
# Keep-MEGA-Alive v1.1
##########################

LOGINS=${1:-"mega-logins.csv"}

if ! [ -x "$(command -v mega-version)" ]; then
	echo 'Error: MEGAcmd is not installed. Get it from https://mega.io/cmd' >&2
	exit 1
fi

mega-logout 1>/dev/null

while IFS= read -r LINE; do
	IFS="," read -a LOGIN <<<$LINE
	echo -e "\n>>> ${LOGIN[0]}"
	mega-login ${LOGIN[0]} ${LOGIN[1]}
	mega-df -h
	mega-logout 1>/dev/null
done <$LOGINS
