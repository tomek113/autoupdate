#!/bin/bash

AUTOUPDATE_PATH=/opt/autoupdate
LOG_FILE=/var/log/autoupdate.log

printf "\n========================================================" >> $LOG_FILE
printf "\nAuto Update Initiated (`date`)\n" >> $LOG_FILE
printf "========================================================\n\n" >> $LOG_FILE

apt update

if [ `apt list --upgradable |grep -v "Listing..." |wc -l` -gt 0 ];
then
	apt upgrade -y >> $LOG_FILE
	if [ $? -eq 0 ]
	then
		cat $AUTOUPDATE_PATH/motd > /etc/motd
        	printf "\nLast Auto Update on: `date`\n\n" >> /etc/motd
		/sbin/shutdown -r 05:00 "Restart after automated patching."
	else
		cat $AUTOUPDATE_PATH/motd > /etc/motd
		printf "\nOops... something went wrong with the update, review logs." >> /etc/motd
		
	fi
else
	printf "No updates avaliable.\n" >> $LOG_FILE
fi
