#!/bin/bash

#Initialize all global variables.
function initVars(){
	local_ip=$(ipconfig | grep "IPv4 Address. . . . . . . . . . . :" | cut -d ':' -f2)
	drive=$(pwd | cut -d'/' -f2)
	plugin_name="CONFIG_PLUGIN"
}

#Check if user wants to execute this plugin Or any other permission your plugin requires.
function checkForPermissions(){
	echo -e "Do you wan to run $plugin_name ? Yes = 1 & No = 0"
	read option
}

#Perform the plugin's task.
function performAction(){
	#Get Inputs
	echo -e "\nEnter Beanstore IP for Hosts file\n"
	read lab_beanstore_ip

	#Setup host file
	echo "$lab_beanstore_ip vbsserver" >> /c/Windows/System32/drivers/etc/hosts
	echo "$local_ip possrv ilfsrv" >> /c/Windows/System32/drivers/etc/hosts

	#Create Shortcuts and bindings
	sh Shortcuts.sh &

	#Create P: Drive
	subst p: /c/ &

	#Copy jdk7
	cp -avr /$drive/Gaurav_Workspace/Tools/JDK/Jdk7 /c/Jdk7 &
}

#Start the script. Please refrain from changing this code.
function startScript(){
	initVars
	touch $(pwd)/plugins/$plugin_name.lock
	checkForPermissions

	if [[ "$option" == 1 ]]; then
		performAction
	else
		echo -e "Bye!"
	fi
	rm $(pwd)/plugins/$plugin_name.lock
}

trap force_exit INT 

function force_exit(){
	if [[ -f $(pwd)/plugins/$plugin_name.lock  ]]; then
		rm $(pwd)/plugins/$plugin_name.lock
	fi
}

#Expands the options provided, Here its used to call startScript.
"$@"