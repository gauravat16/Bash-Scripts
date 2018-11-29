#!/bin/bash

#make your life easier inside VDI

# source  SetUpMyVDI_Plugins/*_plugin.sh

printLogo(){
clear
cat << EOF

   _____      __              __  ___      ______          
  / ___/___  / /___  ______  /  |/  /_  __/ ____/___ _   __
  \__ \/ _ \/ __/ / / / __ \/ /|_/ / / / / __/ / __ \ | / /
 ___/ /  __/ /_/ /_/ / /_/ / /  / / /_/ / /___/ / / / |/ / 
/____/\___/\__/\__,_/ .___/_/  /_/\__, /_____/_/ /_/|___/  
                   /_/           /____/                    
 
EOF
echo -e "by Gaurav Sharma"
}

printLogo

limit=4

for plugin in $(ls plugins | grep "_plugin.sh"); do

	while [[  $(find plugins -name "*.lock" | wc -l) -gt $limit ]]; do
		sleep 10
	done

	echo -e "\nCurrent plugin - $plugin\n"
	start sh --login plugins/$plugin startScript
	sleep 10
done









