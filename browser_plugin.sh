#!/bin/bash

#Initialize all global variables.
function initVars(){
 	drive=$(pwd | cut -d'/' -f2)
	plugin_name="BROWSER_PLUGIN"
}

#Check if user wants to execute this plugin Or any other permission your plugin requires.
function checkForPermissions(){
	echo -e "Do you wan to run $plugin_name ? Yes = 1 & No = 0"
	read option
}

#Perform the plugin's task.
function performAction(){
	#Copy Chrome
	echo -e "Copying Latest Chrome..."
	cp -ar /$drive/Gaurav_Workspace/Tools/Applications/GoogleChromePortable /c/GoogleChromePortable

	#Open MAIL
	echo -e "Launching Mail..."
	start /c/GoogleChromePortable/GoogleChromePortable.exe 'www.outlook.com\owa\walgreens.com' 2>/dev/null

	sleep 3

	#open jira
	echo -e "Launching Jira..."
	start /c/GoogleChromePortable/GoogleChromePortable.exe 'jira\' 2>/dev/null

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

#Expands the options provided, Here its used to call startScript.
"$@"