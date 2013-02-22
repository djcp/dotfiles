#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/mnt/bin:/mnt/sbin:/mnt/usr/bin:/mnt/usr/sbin

#BACKUP_DEVICE_NAME='f38d367a-e63e-495f-97d5-89dd8d333a49'
BACKUP_DEVICE_NAME='usb0'
BACKUP_DIRECTORY_BASE="/media/$BACKUP_DEVICE_NAME"
BACKUP_CONNECTED=`df | grep $BACKUP_DEVICE_NAME | wc -l`

echo $BACKUP_CONNECTED
if [ $BACKUP_CONNECTED -eq 0 ]; then
  exit;
fi

date=`date "+%Y-%m-%dT%H:%M:%S"`
nice rsync -a  --delete --delete-excluded --link-dest=$BACKUP_DIRECTORY_BASE/current --exclude-from=$HOME/bin/backup-excludes /home /etc /var/backups $BACKUP_DIRECTORY_BASE/back-$date

if [ -e $BACKUP_DIRECTORY_BASE/back-$date ]; then
  rm $BACKUP_DIRECTORY_BASE/current
  cd $BACKUP_DIRECTORY_BASE
  touch back-$date
  ln -s back-$date $BACKUP_DIRECTORY_BASE/current
#  cd $BACKUP_DIRECTORY_BASE/current && nice find -type f -printf '#%n - %k - %h/%f\n' | grep '#1 '
#  cd $BACKUP_DIRECTORY_BASE && find -maxdepth 1 -type d -mtime +90 -print0 | xargs -0 rm -Rf
else
  echo "Backup failed!"
fi
