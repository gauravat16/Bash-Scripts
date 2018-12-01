	#!/bin/bash
	#author : Gaurav Sharma
	#Script : Fsync
	#About : This script will backup all the folders mentioned by -d, -g , Documents/Downloads & Code Cloned by Autogit. 


	#Colors

	RED='\033[0;31m'
	WHITE='\033[97m'
	NC='\033[0m'
	BOLD='\033[1m'
	GREEN='\033[92m'
	DIM='\033[2m'
	STOP='\033[0m'

	############################################################


	drive=$(pwd | cut -d'/' -f2)
	username=$(whoami | cut -d'+' -f2)
	BACKUP_LOCK="/$drive/VDI_Backup/$username/backup.lock"
	defaultBackupLocation=/$drive/VDI_Backup/$username
	backupDocuments="c:/Users/$username/Documents/"
	backupDownloads="c:/Users/$username/Downloads/"
	fsync_data="$(pwd)/Fsync_data"
	gitignoreFile="$(pwd)/Fsync_data/fsync.ignore"


	
	directory_array[0]=$backupDownloads
	directory_array[1]=$backupDocuments

	REFRESH_TIME_SECONDS=6000
	options="$@"	


	set_options(){
		prev_option=""

	for option in $options;
	do
		case $prev_option in
			"-t" )
			REFRESH_TIME_SECONDS=$option	
				;;
			"-d" )
				directory_array+=("$option")
				;;
			"-g" )

				git_directory_array+=("$option")			
				;;
		esac

		 prev_option="$option"
	done

	}

	#create a lock file for the backup directory. This file is used to nuke it after 15 days

	touchStartDate(){
		mkdir -p "/$drive/VDI_Backup/$username/"
		touch $BACKUP_LOCK
	}

	#Prints a fancy ass logo.

	printLogo(){
			cat << EOF

_________________                     
___  ____/_  ___/____  _______________
__  /_   _____ \__  / / /_  __ \  ___/
_  __/   ____/ /_  /_/ /_  / / / /__  
/_/      /____/ _\__, / /_/ /_/\___/  
                /____/                

EOF
	}
	

	#Main function of this script, here we backup all the data.
	function backupFolders(){


		cd c:/Users/$username/
		
		 for listRes in $(ls | grep "git_"); do
		 	if [[ $listRes == *"git_"* ]]; then
		 		echo -e "\n${BOLD}Current Directory : $GREEN$listRes${NC}\n"
		   		cd $listRes
		   		copyModifiedFiles $(pwd) "0"
		   		cd ..
		 	fi
		 done

		backupExtraFolders 
		backupGitFolders 

		
	}

	#Backup extra non-git directories
	function backupExtraFolders(){
		for dir in "${directory_array[@]}"; do
			echo -e "\n${BOLD}Current Directory : $GREEN$dir${NC}\n"
			cd $dir
			copyModifiedFiles "$(pwd)" "1"
			cd $(pwd)
		done

	}

	#Backup extra non-git directories
	function backupGitFolders(){

		for dir in "${git_directory_array[@]}"; do
			echo -e "\n${BOLD}Current Directory : $GREEN$dir${NC}\n"
			cd $dir
			copyModifiedFiles "$(pwd)" "0"
			cd $(pwd)
		done

	}

	#Creates directories for backup
	makeDirectories(){
		mkdir -p $defaultBackupLocation$1

	}

	#Heart of this tool, it looks complex, it isn't. The comments will guide you young padawan.
	copyModifiedFiles(){

		#Command mode here signifies whether its a git(0) or non-git(1) directory.
		commandMode=$2

		#Main git command used for backup
		gitCommand="git ls-files .  -m --exclude-standard --others"

		#Here we set min depth of the find command. 
		#Basically, here we restrict find to climb down to depth 1 (1 dir below) or 0 (only this directory)

		if [[ "$commandMode" == "0" ]]; then
			mindepth=1
		else
			mindepth=0
		fi

		#Find folders in each directory & back them up
		find . -maxdepth 1 -mindepth $mindepth -type d | while read result; do

			#Only print subdir name if its a git dir.
			if [[ "$commandMode" == "0" ]]; then
				echo -e "\n${BOLD}Current Sub Directory : $result ${NC}\n"
				cd $result
				fi

			#If this dir is in fsync.ignore then skip it.
				if [ ! -z "$(grep -iow $(basename $result) "$gitignoreFile")" ]; then
					echo -e "$DIM This directory is ignored. $NC"
					cd ..
					continue
					fi			

			checkForgit

			#Create this dir in shared drive
			makeDirectories $(pwd)

			#Get result from copy function
			copyResult=$(copyHelper "$gitCommand" $defaultBackupLocation$(pwd)  2>/dev/null )

			#If we copied something we print an approppriate msg.
			if [[ $copyResult == "" ]]; then
				echo -e "${DIM} No Delta to backup. ${NC}"
				else
					echo -e "${DIM} Backing up Deltas. ${NC}"
			fi

			#If its a git dir then move back a dir, as we have more folders to backup.
			#Else, non git, then break, as we dont need to go into all the folders in a non git folder.
			if [[ "$commandMode" == "0" ]]; then
				cd ..

			else
				break
			fi


		done
	}

	#Copy files to the specified directory.
	copyHelper(){
		gitCommand=$1
		basePath=$2
		for file in $($gitCommand); do
			echo $file
			mkdir -p $basePath/$(dirname $file)
			cp $file $basePath/$(dirname $file)

		done
	}

	#Check if git exists, if not then git init
	checkForgit(){
		if [[ ! -d .git ]]; then
			echo "No Git installation Found. Installing now..."
			git init
		
		fi
	}

	#Delete backup after 15 days.
	nukeUserBackup(){

		if [[ $(find "$BACKUP_LOCK" -mtime +15 -print) ]]; then
			echo -e "Backup older than 15 days. Nuking now"
			rm -rf /$drive/VDI_Backup/$username/*
			touchStartDate
		fi


	}

	#Takes backup every REFRESH_TIME_SECONDS.
	takeBackupLooped(){
		while [[ true ]]; do
			clear
			echo -e "$RED $(printLogo) $NC"
			backupFolders
			echo -e "$RED Sleeping for $REFRESH_TIME_SECONDS seconds"
			sleep $REFRESH_TIME_SECONDS
		done
	}

	#Start Script
	init(){
			set_options
			if [[ -f $BACKUP_LOCK ]]; then
					nukeUserBackup
				else
					touchStartDate

			fi

			takeBackupLooped

		
		
	}


	init
