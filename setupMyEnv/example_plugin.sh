#!/bin/bash

#Initialize all global variables.
function initVars(){
	plugin_name="NAME_PLUGIN"
}

#Check if user wants to execute this plugin Or any other permission your plugin requires.
function checkForPermissions(){
	echo -e "Do you wan to run $plugin_name ? Yes = 1 & No = 0"
	read option
}

#Perform the plugin's task.
function performAction(){
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
