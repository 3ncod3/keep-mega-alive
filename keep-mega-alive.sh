#!/bin/bash
###
# Keep-MEGA-Alive
# https://github.com/3ncod3/keep-mega-alive
###########################################

exec 4>>~/keep-mega-alive.log
exec 5> >(tee -a ~/keep-mega-alive.log) 2>&1

VERSION=1.2
LOGINS=${1:-"mega-logins.csv"}

if [[ $1 == "--version" ]]; then
        echo "Keep-MEGA-Alive v$VERSION"
        exit 0
fi

log_msg() {
        msg=$1
        echo -e "$(date +"%Y-%m-%dT%H:%M:%S%:z") : $msg" >&4
}

if ! [ -x "$(command -v mega-version)" ]; then
        echo 'Error: MEGAcmd is not installed. Get it from https://mega.io/cmd' >&2
        exit 1
fi

log_msg "Starting Keep-MEGA-Alive v$VERSION"

mega-logout 1>/dev/null

IFS=","
while read -r username password; do
        username=$(echo "$username" | tr -d '[:space:]')
        password=$(echo "$password" | tr -d '[:space:]')
        echo -e "\n>>> $username"
        log_msg "Trying to login as $username"

        mega-login $username $password >&5
        if [ ! $? -eq 0 ]; then
                echo "Unable to login as $username"
                log_msg "[ERROR] Unable to login as $username"
                continue
        fi

        log_msg "Successfully logged in as $username"

        mega-df -h >&5

        mega-logout 1>/dev/null
        log_msg "Logged out from $username"

done <$LOGINS

log_msg "Finished running Keep-MEGA-Alive \n"

exec 4>&-
exec 5>&-
