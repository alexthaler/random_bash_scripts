#!/usr/bin/env bash 

echo "encrypting..."

BACKUP_DIR="/Volumes/Private/Backup"
BACKUP_TIMESTAMP=$(date +"%m_%d_%y_%H_%M_%S")
BACKUP_ARCHIVE_NAME="backup_$BACKUP_TIMESTAMP"

echo "Creating backup of $BACKUP_DIR"
echo "Outputting to $BACKUP_ARCHIVE_NAME.des3"

# Because I'll inevitably question using des3 it's cool http://www.voltage.com/blog/crypto/is-triple-des-not-secure-enough/
tar -zcf - "$BACKUP_DIR" | openssl des3 -salt -k "this_is_where_you_put_a_super_secure_password" | dd of="$BACKUP_ARCHIVE_NAME".des3
