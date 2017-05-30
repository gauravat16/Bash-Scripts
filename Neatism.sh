#!/bin/bash	
echo "Neatism - For nerds with OCD"

#Adds Underscore for every space in file name

for f in *\ *; do mv "$f" "${f// /_}"; done



sort_and_move(){
caseVal=$1
folder=$2

mkdir $folder 
case $caseVal in
	1 )
echo "Sorting Images"
mv $(ls | grep -e ".png" -e ".jpeg" -e ".jpg" -e ".svg" -e ".JPG" -e ".gif" -e ".psd") $folder 

;;

2)
echo "Sorting Documents"

mv $(ls | grep -e ".pdf" -e ".doc" -e ".xls" -e ".ppt" -e ".pptx" -e ".ppt") $folder

;;

3)
echo "Sorting Archives"

mv $(ls | grep -e ".tar" -e ".gz" -e ".zip" -e ".7z" -e ".rar" -e ".lha" -e ".arj" -e ".iso" -e ".cabinet" -e ".jar" -e ".ace") $folder

;;

4)
echo "Sorting Applications"

mv $(ls | grep -e ".apk" -e ".deb" -e ".exe" -e ".dmg" -e ".app") $folder

;;

5)
echo "Sorting Torrents"

mv $(ls | grep -e ".torrent") $folder

;;

6)
echo "Sorting Fonts"

mv $(ls | grep -e ".ttf") $folder

;;
esac





}

sort_and_move '1' 'Images/'
sort_and_move '2' 'Documents/'
sort_and_move '3' 'Archives/'
sort_and_move '4' 'Applications/'
sort_and_move '5' 'Torrents/'
sort_and_move '6' 'Fonts/'








