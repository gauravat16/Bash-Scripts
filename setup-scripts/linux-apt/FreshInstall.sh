#Get Updated
sudo apt-get update && sudo apt-get upgrade

#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

#install MySQL 5.6
sudo apt-get install mysql-server-5.6

#install TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
sudo tlp start

#Set up Folder
mkdir Dev

#Download Eclipse
cd ~
cd Dev
wget http://ftp.daumkakao.com/eclipse/technology/epp/downloads/release/neon/R/eclipse-jee-neon-R-linux-gtk-x86_64.tar.gz
tar -xvzf eclipse-jee-neon-R-linux-gtk-x86_64.tar.gz

#install java8
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

#MySQL Workbench
sudo apt-get install mysql-workbench

#Android Studio
sudo apt-add-repository ppa:paolorotolo/android-studio 
sudo apt-get update 
sudo apt-get install android-studio

