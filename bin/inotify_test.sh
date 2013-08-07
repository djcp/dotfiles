#!/bin/sh

WATCHED_DIR=$HOME/code/work/chillingeffects

inotifywait --exclude="/tags.*|log/|tmp/|\.git/|coverage/|doc/"\
  -m -r -e modify -e move -e create -e delete $WATCHED_DIR | while read line
do
  ctags -f $WATCHED_DIR/tags -R --exclude='*.js' --langmap='ruby:+.rake.builder.rjs' --languages=-javascript $WATCHED_DIR/
  DATE=`date`
  echo "updated because of $line on $DATE"
done
