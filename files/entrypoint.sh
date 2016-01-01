#!/bin/bash

case "$1" in
    'bash')
        exec bash
        ;;
    'gen-key')
        if [ "random" = "$PASSPHRASE" ]; then
            PASSPHRASE=$(pwgen 16 1)
        fi
        cat << EOF | gpg --batch --gen-key
        %echo Generating a key
        Key-Type: $KEY_TYPE
        Key-Length: $KEY_LENGTH
        Subkey-Type: $SUBKEY_TYPE
        Subkey-Length: $SUBKEY_LENGTH
        Name-Real: $NAME_REAL
        Name-Email: $NAME_EMAIL
        Expire-Date: 0
        Passphrase: $PASSPHRASE
        %commit
        %echo Created key with passphrase '$PASSPHRASE'
EOF
        exit
        ;;
    '/bin/bash')
        exec cat << EOF
This is the duply docker container.

Please specify a command:

  bash
     Open a command line prompt in the container.

  gen-key
     Create a GPG key to be used with duply.

  usage
     Show duply's usage help.

All other commands will be interpreted as commands to duply.
EOF
        ;;
    *)
        DUPL_PARAMS="$DUPL_PARAMS --allow-source-mismatch"
        exec duply "$@"
        ;;
esac
