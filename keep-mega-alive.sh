#!/bin/bash

# Keep-MEGA-Alive
# https://github.com/3ncod3/keep-mega-alive

VERSION=1.2
LOGINS=${1:-"mega-logins.csv"}
LOGFILE="$HOME/keep-mega-alive.log"

if [[ $1 == "--version" ]]; then
        echo "Keep-MEGA-Alive v$VERSION"
        exit 0
fi

# Check if MEGAcmd is installed
if ! [ -x "$(command -v mega-version)" ]; then
        echo 'Error: MEGAcmd is not installed. Get it from https://mega.io/cmd' >&2
        exit 1
fi

# Check if login file exists and is readable
if [ ! -r "$LOGINS" ]; then
        echo "Error: Login file $LOGINS does not exist or is not readable" >&2
        exit 1
fi

# Open log file for writing
exec 4>>"$LOGFILE"
exec 5> >(tee -a "$LOGFILE") 2>&1

# Log start message
echo -e "$(date +"%Y-%m-%dT%H:%M:%S%:z") : Starting Keep-MEGA-Alive v$VERSION" >&4

mega-logout 1>/dev/null

# Loop through login file
while IFS="," read -r username password; do
        # Trim whitespace from username and password
        username=$(echo "$username" | tr -d '[:space:]')
        password=$(echo "$password" | tr -d '[:space:]')

        # Skip line if username or password is empty
        if [ -z "$username" ] || [ -z "$password" ]; then
                echo "Warning: Invalid login credentials in login file, skipping line" >&2
                continue
        fi

        echo -e "\n>>> Logging in as $username" >&5

        # Attempt login
        if ! mega-login "$username" "$password" >&5; then
                echo "Error: Login failed for user $username" >&2
                continue
        fi

        echo "Successfully logged in as $username"

        # Get account information
        mega-df -h >&5

        # Log out
        mega-logout >&5
        echo "Logged out from $username"
        sleep 10

done < "$LOGINS"

# Log finish message and close log file
echo -e "$(date +"%Y-%m-%dT%H:%M:%S%:z") : Finished running Keep-MEGA-Alive\n" >&4
exec 4>&-
exec 5>&-
