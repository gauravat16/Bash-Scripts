#!/bin/bash

#This Script allows logging in bash

#######################################################
#COLOURS
#######################################################
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White




#######################################################
DEBUG=""
LOG_LOCATION=""
LOG_NAME=""
NO_LOG=""
NO_COLOR=""
options="$@"	
LOG_PROPERTIES=""
MAX_LOG_FILE_SIZE=""
COMPRESS_LOGS=""
TAG="LOGX-INTERNAL-LOG"



set_options(){
for option in $options;
do
	case $option in
		"-debug" )
			DEBUG="-debug"
			;;

		"-nolog" )
			NO_LOG="-nolog"
			;;

		"-nocolor" )
			NO_COLOR="-nocolor"
			;;	

	esac
done

}

load_vars(){
	LOG_PROPERTIES="$1"
	if [[ ! -f "$LOG_PROPERTIES" ]]; then
		NO_LOG="-nolog"
		log_error "LOGX" "$LOG_PROPERTIES is missing."
		exit
		
	fi

	while read -r line; do
		if [[ ! -z "$line" ]]; then
			local key=$(echo "$line" | cut -d "=" -f1)			
			local value=$(echo "$line" | cut -d "=" -f2)

			case "$key" in
							"LogLocation" )
								LOG_LOCATION="$value"
								;;
							"MaxLogFileSize" )
								MAX_LOG_FILE_SIZE="$value"
								;;
							"CompressLogs" )
								COMPRESS_LOGS="$value"
								;;

							"ScriptName" )
								LOG_NAME="$value"
								;;

						esac			

		fi
	done < "$LOG_PROPERTIES"

}

compress_logs(){
	if [[ ! -z "$COMPRESS_LOGS" ]] && [[ "$COMPRESS_LOGS" == "true" ]]; then
		log="$1"
		gzip "$log"
	fi
	
}

write_logs(){
	local current_dir=$PWD
	local time_stamp=$(date +"%Y-%m-%d_%H-%M-%S")

	if [[ ! -d "$LOG_LOCATION" ]]
		then
			mkdir $LOG_LOCATION
		else
			cd $LOG_LOCATION
	fi	
	local log_name=$1
	local log_line=$2
	local latest_file=$(ls -t | grep "$log_name"|head -n1 )
	if [[ -z "$latest_file" ]]
		then
		echo $log_line >> "$log_name"_"$time_stamp".log

		else
			local size=$(wc -c < "$latest_file" | sed 's/ //g' )
			if [[ "$size" -lt "$MAX_LOG_FILE_SIZE" ]]
			then
			echo $log_line >> $latest_file
			else
				compress_logs "$(pwd)/$latest_file"
				echo $log_line >> "$log_name"_"$time_stamp".log
			fi
		
	fi
	cd $current_dir

}


log_basic(){
local tag=$1
local log=$2
local colour_bg=$3
local caller_fn=$4
local log_type=$5
local caller_file=$(echo "$(echo "$caller_fn"| cut -d " " -f2)" | cut -d "." -f1)
local caller_line_number=$(echo "$caller_fn"| cut -d " " -f1)

local time_stamp=$(date +"%Y-%m-%d::%H:%M:%S")
local log_line="$log_type:$time_stamp:$caller_file:$caller_line_number:$tag:$log"
if [[ $DEBUG == "-debug" ]]
then
if [[ -z "$NO_COLOR" ]]; then
	printf "$colour_bg%s$Color_Off\n" "$log_line"
else
		printf "%s\n" "$log_line"
fi
fi

if [[  -z "$NO_LOG" ]]; then
	write_logs "$LOG_NAME" "$log_line"
fi
}

log_info(){

local tag=$1
local log=$2
local caller_fn=$(caller)

log_basic "$tag" "$log" "$On_IGreen" "$caller_fn" "INFO"
}

log_warn(){
local tag=$1
local log=$2
local caller_fn=$(caller)

log_basic "$tag" "$log" "$On_IBlue" "$caller_fn" "WARN"
}

log_error(){
local tag=$1
local log=$2
local caller_fn=$(caller)
log_basic "$tag" "$log" "$On_IRed" "$caller_fn" "ERROR"
}

log_init(){
	
	set_options
	load_vars $1
	
}


