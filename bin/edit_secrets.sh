#!/bin/bash

KEYS="3BC1C2C3"

PRIVATE_STORE_TXT="$HOME/Private/${USER}_private_store.txt"
PRIVATE_STORE_ENCRYPTED="${PRIVATE_STORE_TXT}.asc"
MD5SUM="${PRIVATE_STORE_TXT}.md5sum"
NEW_MD5SUM="${PRIVATE_STORE_TXT}.md5sum.new"
SYNC_TO="djcp@collispuro.com:/home/djcp/Private/"

# Always delete the unencrypted file at the end of the session. We DO NOT want this hanging around.
trap "rm -f \"$PRIVATE_STORE_TXT\"; chmod 600 \"$PRIVATE_STORE_TXT\"*; exit" INT TERM EXIT

log_if_verbose() {
  if [ "$VERBOSE" -eq 1 ]; then
    echo -ne $1
  fi
}

source_rc_optionally() {
  RC_FILE="$HOME/.secrets.rc"
  if [ -e $RC_FILE ]; then
    log_if_verbose "Using RC: $RC_FILE\n"
    . $RC_FILE
  fi
}

init_storage() {
  if [ ! -e "$HOME/Private" ]
  then
    mkdir -m 700 "$HOME/Private"
    umask 77 "$HOME/Private/"
  fi

  touch $PRIVATE_STORE_TXT
  chmod 600 $PRIVATE_STORE_TXT
}

decrypt_and_edit() {
  gpg --no-use-agent --decrypt $PRIVATE_STORE_ENCRYPTED > $PRIVATE_STORE_TXT
  vim $PRIVATE_STORE_TXT
}

calc_md5sum(){
  md5sum < $PRIVATE_STORE_TXT > $NEW_MD5SUM
}

no_changes() {
  clear
  rm -f $NEW_MD5SUM
  echo 'No changes, not re-encrypting'
  exit
}

encrypt_and_sync() {
  mv $NEW_MD5SUM $MD5SUM
  echo 'File has changed. Re-encrypting. . .'
  gpg -a --encrypt -r $KEYS $PRIVATE_STORE_TXT
  clear

  echo 'Syncing to collispuro.com'
  scp $MD5SUM \
    $PRIVATE_STORE_ENCRYPTED \
    $SYNC_TO
}

init_storage
decrypt_and_edit
calc_md5sum

if [ -e $NEW_MD5SUM ]
then
    if cmp $NEW_MD5SUM $MD5SUM
    then
      no_changes
    else
      encrypt_and_sync
    fi
fi
