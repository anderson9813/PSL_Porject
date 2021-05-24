
#!/bin/bash



LOG_LOC=/var/log/mybackup.log


##Start Functions
function check_dir_loc {
	#to check whether the dir list file exists

	if [ ! -s "/backup_dirs.conf" ]
	then
		echo "Please create a list of directories  to backup by creating a backup_dirs.conf file in the root directory"
		
		exit 1
	fi
}

function check_backup_loc {
	
	if [ ! -s "/backup_loc.conf" ]
        then
                echo "Please create a list of directories  to backup by creating a backup_loc.conf file in the root directory"

                exit 1
        fi



}




function check_schedule {
	#check to see if script exits in hourly cron directory
	if [ ! -s "/etc/cron.hourly/make_backup" ]
	then 
		#copy script to cron.weekly dir
		sudo cp auto_backup_1.sh /etc/cron.hourly/make_backup
		echo "The backup schedule has been set to hourly"
		echo "The exact run time is in the /etc/crontab file"
		exit 1
	fi
}

function perform_backup {
	#get backup location
	backup_path=$(cat /backup_loc.conf)
	echo "backup starting..."> $LOG_LOC
	#for each dir,archieve and compress to backup location
	while read dir_path
	do
		#get backup dir name
		dir_name=$(basename $dir_path)
		extension=.tar.gz

		#create filename for compressed bakcup
		filename=$backup_path$dir_name$extension
		#archieve dirs and compress archieve
		tar -zcf $filename $dir_path 2>> $LOG_LOC

		#change ownership of backup files
		chown $USER:$USER $filename
		echo "Backuping up of $dir_name completed." >> $LOG_LOC

	done < /backup_dirs.conf
	echo "Backup completed at ;" >> $LOG_LOC
	date >> $LOG_LOC

}
##end Functions

check_dir_loc
check_backup_loc
check_schedule
perform_backup
