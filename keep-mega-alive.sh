#!/bin/sh
###
# Keep-MEGA-Alive v1
##########################

LOGINS=${1:-"mega-logins.csv"}

while IFS= read -r LINE; do
	IFS="," read -a LOGIN <<< $LINE
	echo -e "\n\n>>> ${LOGIN[0]}\n"
	mega-login "${LOGIN[0]}" "${LOGIN[1]}" 
	mega-df -h
	mega-logout
done < $LOGINS
