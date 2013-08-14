#!/bin/bash
cd

DIRS="
.Skype
.cache
.config
.gnupg
.gnome2
.gnome2_private
.heroku
.mozilla
.muttrc
.netrc
.ssh
.vmail
.vmailrc
Documents
"

for DIR in $DIRS; do
  TARGET="$HOME/$DIR"
  PRIVATE_TARGET="$HOME/Private/$DIR"

  if [ ! -L "$TARGET" ]; then
    echo "copying $TARGET to ~/Private/ and linking"
    mv $TARGET $PRIVATE_TARGET
    ln -s $PRIVATE_TARGET $TARGET
  else
    echo "Already linked: $DIR"
  fi

done
