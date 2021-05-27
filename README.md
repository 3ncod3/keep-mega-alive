# Keep-MEGA-Alive

A script to keep your mega account(s) alive and print their used storage info
(`df -h`).

Automatically logs every run in the `~/keep-mega-alive.log` file (since v1.2)
## Installation

### 1. Install MEGAcmd

Get it from https://mega.io/cmd or using APT

#### Using APT (Debian/Ubuntu)

The advantage of doing it this way is that updates of MEGAcmd will be
automatically fetched and installed when you upgrade your packages.

Add the MEGA signing key for the repository

```sh
curl -fsSL https://mega.nz/keys/MEGA_signing.key | sudo apt-key add -
```

Add the repo, replace `<OS>` with your OS version path found under
https://mega.nz/linux/MEGAsync/

```sh
sudo echo "deb https://mega.nz/linux/MEGAsync/<OS>/ ./" > /etc/apt/sources.list.d/mega-nz.list
```

Then just install it

```sh
sudo apt update
sudo apt install megacmd
```

### 2. Download the script

From your home directory (`~`), download the latest version of the script and
make it executable

```sh
curl -O https://raw.githubusercontent.com/3ncod3/keep-mega-alive/main/keep-mega-alive.sh
chmod u+x keep-mega-alive.sh
```

### 3. Create the logins file

Create a `mega-logins.csv` CSV file with your mega logins, with each email and
password being separated by a comma and on a separate line, under your home
directory like so:

```csv
example1@example.com,password1
example2@example.com,password2
example3@example.com,password3
```

### Windows

For Windows, download and use the `keep-mega-alive.bat` file instead of the
`keep-mega-alive.sh` file everywhere.

```
https://raw.githubusercontent.com/3ncod3/keep-mega-alive/main/keep-mega-alive.bat
```

## Upgrade

Upgrade your current version of the script by simply re-downloading it

```sh
curl -O https://raw.githubusercontent.com/3ncod3/keep-mega-alive/main/keep-mega-alive.sh
chmod u+x keep-mega-alive.sh
```

## Usage

Once you have created `mega-logins.csv` in your home directory and the script is
executable (see Installation), just run it:

```sh
~/keep-mega-alive.sh
```

### Specify logins file path

By default, the script is going look for the `mega-logins.csv` file under the
same directory the script resides under but you can specify a path to this file
like so:

```sh
~/keep-mega-alive.sh path/to/logins-file.csv
```

### Schedule regular runs

You can use [`crontab`](https://linux.die.net/man/5/crontab) to schedule the
script to run at a regular interval by adding an entry to your cronfile (run
`crontab -e`).

#### Run every month

```sh
0 0 1 * * path/to/keep-mega-alive.sh &>/dev/null
```

#### Run every other month

```sh
0 0 1 */2 * path/to/keep-mega-alive.sh &>/dev/null
```

#### Run every 3rd month

```sh
0 0 1 */3 * path/to/keep-mega-alive.sh &>/dev/null
```

### Parse log file for login errors

The script logs everything in the file `keep-mega-alive` in your home directory. If you want to look at unsuccessful login attempts run

```sh
cat  ~/keep-mega-alive.log | grep ERROR
```

### Version

Find your script version by running

```sh
~/keep-mega-alive.sh --version
```