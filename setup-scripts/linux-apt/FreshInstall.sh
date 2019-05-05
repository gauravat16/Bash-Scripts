#Vars
SOFTWARES="$HOME/softwares"
INSTALLATIONS="$HOME/installs"

#Set up Folder
mkdir -p $SOFTWARES
mkdir -p $INSTALLATIONS

#Get Updated
sudo apt-get update && sudo apt-get upgrade

#install chrome
wget -v https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P $SOFTWARES
sudo dpkg -i  $SOFTWARES/google-chrome-stable_current_amd64.deb

#install MySQL 5.7
sudo apt-get install mysql-server-5.7

#install TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
sudo tlp start

#Download Eclipse and STS
sudo snap install --classic eclipse

wget -v https://download.springsource.com/release/STS/3.9.8.RELEASE/dist/e4.11/spring-tool-suite-3.9.8.RELEASE-e4.11.0-linux-gtk-x86_64.tar.gz -P $SOFTWARES

tar -xzf ~/Dev/spring-tool-suite-3.9.8.RELEASE-e4.11.0-linux-gtk-x86_64.tar.gz  -C $INSTALLATIONS

#install java8
sudo apt update
sudo apt install openjdk-8-jdk

#MySQL Workbench
sudo apt-get install mysql-workbench

#Android Studio
sudo snap install android-studio --classic

#VSCode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

