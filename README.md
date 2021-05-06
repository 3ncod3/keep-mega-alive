# keep-mega-alive
A script to keep your mega account(s) alive and print their used storage info (`df -h`).

## Installation

### Install MEGAcmd

Go to https://github.com/meganz/MEGAcmd for full instructions.

#### Debian/Ubuntu via APT

The advantage of doing it this way is that updates of MEGAcmd will be automatically fetched and installed when you upgrade your packages.


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

## Usage

Create a `mega-logins.csv` file with your mega logins under the same directory
as the script like so:

```csv
example1@example.com,password1
example2@example.com,password2
example3@example.com,password3
...
```

Now make it executable

```sh
chmod u+x keep-mega-alive.sh
```

And run it :)

```sh
./keep-mega-alive.sh
```

### Login file path

By default, the script is going look for this file under the same directory the
script resides under but you can specify a path to this file like so:

```sh
./keep-mega-alive.sh path/to/login-file.csv
```

### Regular interval runs

You can use [`crontab`](https://linux.die.net/man/5/crontab) to schedule the
script to run at a regular interval by an entry to your cronfile (run `crontab
-e`).

#### Run every month

```sh
0 0 1 * * path/to/keep-mega-alive.sh
```

#### Run every other month

```sh
0 0 1 */2 * path/to/keep-mega-alive.sh
```

#### Run every 3rd month

```sh
0 0 1 */3 * path/to/keep-mega-alive.sh
```