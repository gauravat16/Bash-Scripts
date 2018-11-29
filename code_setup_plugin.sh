#!/bin/bash
source  $(pwd)/AutoGit.sh "FROM_SETUP_MY_VDI"

#Initialize all global variables.
function initVars(){
 	drive=$(pwd | cut -d'/' -f2)
	plugin_name="CODE_SETUP"
}

#Check if user wants to execute this plugin Or any other permission your plugin requires.
function checkForPermissions(){
	echo -e "Do you wan to run $plugin_name ? Yes = 1 & No = 0"
	read option
}

#Perform the plugin's task.
function performAction(){
	echo -e "\nDo you want to setup your workspace? y/n\n"
	read shouldBuild

	#Setup workspace
	if [[ "$shouldBuild" == "y" ]]; then
		echo -e "\nOpening Repos file to edit.\n"

		#open notepad ++ && Repos
		'T:\Notepad++\Notepad++.exe' repos.txt
		buildCodeBase
	else
		exit
	fi
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