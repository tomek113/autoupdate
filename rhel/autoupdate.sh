#!/bin/bash

AUTOUPDATE_PATH=/opt/autoupdate
LOG_FILE=/var/log/autoupdate.log

printf "\n========================================================" >> $LOG_FILE
printf "\nAuto Update Initiated (`date`)\n" >> $LOG_FILE
printf "========================================================\n\n" >> $LOG_FILE

yum check-update

if [ $? -eq 100 ];
then
	yum upgrade -y >> $LOG_FILE && /usr/sbin/shutdown -r 05:00 "Restart after automated patching"
	cat $AUTOUPDATE_PATH/motd > /etc/motd
	printf "\nLast Auto Update on: `date`\n\n" >> /etc/motd	
else
	printf "No updates avaliable.\n" >> $LOG_FILE
fi
