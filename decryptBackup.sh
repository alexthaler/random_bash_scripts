#!/usr/bin/env bash

if [ -z $1 ]
    then
        echo "Argument not provided, please provide file to decrypt"
        exit 1
fi

echo "decrypting $1"

ARCHIVE_FILE=$1

DATE_STRING=`echo "$ARCHIVE_FILE" | cut -d '_' -f 2 | cut -d '.' -f 1`

echo $DATE_STRING

PASSWORD=`./generatePassword.rb $DATE_STRING`
echo $PASSWORD

dd if="$ARCHIVE_FILE" | openssl des3 -d -k "$PASSWORD" | tar zxf -
