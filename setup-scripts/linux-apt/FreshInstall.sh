#Colors
	RED='\033[0;31m'
	WHITE='\033[97m'
	NC='\033[0m'
	BOLD='\033[1m'
	GREEN='\033[92m'
	DIM='\033[2m'
	STOP='\033[0m'



#install chrome
function installChrome(){
    wget -v https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P $SOFTWARES
    sudo dpkg -i  $SOFTWARES/google-chrome-stable_current_amd64.deb
}


#install MySQL 5.7
function installMySql(){
    sudo apt-get install mysql-server-5.7
}

#install TLP
function installTLP(){
    sudo add-apt-repository ppa:linrunner/tlp
    sudo apt-get update
    sudo apt-get install tlp tlp-rdw
    sudo tlp start
}

#Download Eclipse and STS
function installEclipseBasedIde(){
    sudo snap install --classic eclipse
    wget -v https://download.springsource.com/release/STS/3.9.8.RELEASE/dist/e4.11/spring-tool-suite-3.9.8.RELEASE-e4.11.0-linux-gtk-x86_64.tar.gz -P $SOFTWARES
    tar -xzf ~/Dev/spring-tool-suite-3.9.8.RELEASE-e4.11.0-linux-gtk-x86_64.tar.gz  -C $INSTALLATIONS
}


#install java8
function installJDK(){
    sudo apt update
    sudo apt install openjdk-8-jdk
}


#MySQL Workbench
function installWorkbench(){
    sudo apt-get install mysql-workbench
}

#Android Studio
function installAndroidStudio(){
    sudo snap install android-studio --classic
}

#VSCode
function installVSCode(){
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
}

#Docker
function installDocker(){
installDockerCE
installDockerCompose
}

function installDockerCE(){
sudo apt-get update
 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
       sudo apt update
   sudo apt-get install docker-ce docker-ce-cli containerd.io
}

function installDockerCompose(){
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

function init(){
    #Vars
    SOFTWARES="$HOME/softwares"
    INSTALLATIONS="$HOME/installs"
    
    
    #Get Updated
    #sudo apt-get update && sudo apt-get upgrade

    #Set up Folder
    mkdir -p $SOFTWARES
    mkdir -p $INSTALLATIONS
    
    for fn in $(declare -F)
    do
      if [[ $fn == install* ]]
      then
        echo -e "$GREEN""\nRunning installation subroutine - [$fn]........ $STOP\n"
        time $fn
        echo -e "$GREEN""\n[$fn] - Done!$STOP\n"

      fi
    done

}

init
