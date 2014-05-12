#!/usr/bin/env bash

echo "Copying files as configured to the Backup directory in Private"

rm -r /Volumes/Private/Backup/1Password.agilekeychain/
cp -r $HOME/Dropbox/1Password.agilekeychain/ /Volumes/Private/Backup/1Password.agilekeychain/

echo "encrypting..."

BACKUP_DIR="/Volumes/Private/Backup"
BACKUP_TIMESTAMP=$(date +"%m%d%Y%H%M%S")
BACKUP_ARCHIVE_NAME="backup_$BACKUP_TIMESTAMP.des3"

# Spaces don't need to be escaped here because bash takes care of it
# TODO add tarsnap support
declare -a BACKUP_DESTINATIONS=("/tmp/" "$HOME/Google Drive/Backups/" "$HOME/Dropbox/Backups/")

echo "Creating backup of $BACKUP_DIR"
echo "Outputting to $BACKUP_ARCHIVE_NAME"

BACKUP_PASSWORD=`./generatePassword.rb $BACKUP_TIMESTAMP`
echo "Password $BACKUP_PASSWORD"

# Because I'll inevitably question using des3 it's cool http://www.voltage.com/blog/crypto/is-triple-des-not-secure-enough/
tar -zcf - "$BACKUP_DIR" | openssl des3 -salt -k "$BACKUP_PASSWORD" | dd of="$BACKUP_ARCHIVE_NAME"

for i in "${BACKUP_DESTINATIONS[@]}"
do
  echo "Copying to $i"
  cp "$BACKUP_ARCHIVE_NAME" "$i"
done

rm "$BACKUP_ARCHIVE_NAME"
