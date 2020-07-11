#Colors
	RED='\033[0;31m'
	WHITE='\033[97m'
	NC='\033[0m'
	BOLD='\033[1m'
	GREEN='\033[92m'
	DIM='\033[2m'
	STOP='\033[0m'

#install command line tools
function setupCommandLineTools(){
    xcode-select --install
}

#install brew
function setupHomeBrew(){
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install wget
}

#install jdk8
function installJDK8(){
    brew tap AdoptOpenJDK/openjdk
    brew cask install adoptopenjdk8
}

#install chrome
function installChrome(){
    brew cask install google-chrome
}

#install vscode
function installVsCode(){
    brew cask install visual-studio-code
}

#install sts
function installSTS(){
    wget -v https://download.springsource.com/release/STS4/4.2.2.RELEASE/dist/e4.11/spring-tool-suite-4-4.2.2.RELEASE-e4.11.0-macosx.cocoa.x86_64.dmg -P $SOFTWARES
    sudo hdiutil attach ~/Dev/spring-tool-suite-4-4.2.2.RELEASE-e4.11.0-macosx.cocoa.x86_64.dmg
    open '/Volumes/Spring Tool Suite 4'
}

#install docker
function installDocker(){
    wget -v https://download.docker.com/mac/stable/Docker.dmg -P $SOFTWARES
    sudo hdiutil attach ~/Dev/Docker.dmg
    open '/Volumes/Docker'
}

#install postman
function installPostman(){
    brew cask install postman
}

function installMongoCompass(){
    brew cask install mongodb-compass
}

function installMySqlWorkbench(){
    brew cask install mysqlworkbench
}

function installIdeaCE(){
    brew cask install intellij-idea-ce
}

function init(){
    
    setupCommandLineTools
    setupHomeBrew

    #Vars
    SOFTWARES="$HOME/softwares"
    INSTALLATIONS="$HOME/installs"

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
