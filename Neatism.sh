#!/bin/bash	
cat << "EOF"

    _   __           __  _              
   / | / /__  ____ _/ /_(_)________ ___ 
  /  |/ / _ \/ __ `/ __/ / ___/ __ `__ \
 / /|  /  __/ /_/ / /_/ (__  ) / / / / /
/_/ |_/\___/\__,_/\__/_/____/_/ /_/ /_/ 
                                        
EOF

#Adds Underscore for every space in file name

for f in *\ *; do mv "$f" "${f// /_}"; done &>/dev/null

folder_array=("Images" "Documents" "Archives" "Applications" "Torrents" "Fonts" "Videos" "Music" "DB_Files" "Game_Files" "Web_Files" "Folders" )

#Define paths for neatism targets
paths_array=("/Users/gaurav/Downloads" "/Users/gaurav/Scripts")

sort_and_move(){
caseVal=$1
folder=$2

mkdir -p $folder &>/dev/null
case $caseVal in
	1 )
echo "Sorting Images"
mv $(ls | grep -i -e ".bmp" -e ".dds" -e ".gif"  -e ".jpg"  -e ".png" -e ".psd"  -e ".pspimage"  -e ".tga"  -e ".thm" -e ".tif"  -e ".tiff"  -e ".yuv"  -e ".ai"  -e ".eps"  -e ".ps" -e ".svg") $folder &>/dev/null

;;

2)
echo "Sorting Documents"

mv $(ls | grep -i -e  ".csv"  -e  ".dat"  -e  ".ged"  -e  ".key"  -e  ".keychain"  -e  ".pps"  -e  ".ppt"  -e  ".pptx"  -e  ".sdf"  -e  ".tar"  -e  ".tax2016"  -e  ".vcf"  -e  ".xml"  ) $folder &>/dev/null
mv $(ls | grep -i -e  ".doc"  -e  ".docx"  -e  ".log"  -e  ".msg"  -e  ".odt"  -e  ".pages"  -e  ".rtf"  -e  ".tex"  -e  ".txt"  -e  ".wpd"  -e  ".wps"  ) $folder &>/dev/null
mv $(ls | grep -i -e  ".pdf"  -e  ".doc"  -e  ".xls"  -e  ".ppt"  -e  ".pptx" -e  ".indd"  -e  ".pct"  -e  ".xlr"  -e  ".xlsx"  ) $folder &>/dev/null


;;

3)
echo "Sorting Archives"

mv $(ls | grep -i -e  ".7z"  -e  ".cbr"  -e  ".deb"  -e  ".gz"  -e  ".pkg"  -e  ".rar"  -e  ".rpm"  -e  ".sitx"  -e  ".tar.gz"  -e  ".zip"  -e  ".zipx"  -e  ".bin"  -e  ".cue"  -e  ".dmg"  -e  ".iso"  -e  ".mdf"  -e  ".toast"  -e  ".vcd"  ) $folder &>/dev/null

;;

4)
echo "Sorting Applications"

mv $(ls | grep  -i -e  ".apk"  -e  ".app"  -e  ".bat"  -e  ".cgi"  -e  ".com"  -e  ".exe"  -e  ".gadget"  -e  ".jar"  -e  ".wsf"  ) $folder &>/dev/null

;;

5)
echo "Sorting Torrents"

mv $(ls | grep -i -e ".torrent") $folder &>/dev/null

;;

6)
echo "Sorting Fonts"

mv $(ls | grep -i -e  ".fnt"  -e  ".fon"  -e  ".otf"  -e  ".ttf"  ) $folder &>/dev/null

;;

7)
echo "Sorting Videos"

mv $(ls | grep -i -e  ".3g2"  -e  ".3gp"  -e  ".asf"  -e  ".avi"  -e  ".flv"  -e  ".m4v"  -e  ".mov"  -e  ".mp4"  -e  ".mpg"  -e  ".rm"  -e  ".srt"  -e  ".swf"  -e  ".vob"  -e  ".wmv"  ) $folder &>/dev/null
mv $(ls | grep -i -e  ".3dm"  -e  ".3ds"  -e  ".max"  -e  ".obj"  ) $folder &>/dev/null
;;

8)
echo "Sorting Music"
mv $(ls | grep -i -e  ".aif"  -e  ".iff"  -e  ".m3u"  -e  ".m4a"  -e  ".mid"  -e  ".mp3"  -e  ".mpa"  -e  ".wav"  -e  ".wma"  ) $folder &>/dev/null


;;

9)
echo "Sorting Database Files"

mv $(ls | grep  -i -e  ".accdb"  -e  ".db"  -e  ".dbf"  -e  ".mdb"  -e  ".pdb"  -e  ".sql" ) $folder &>/dev/null

;;

10)
echo "Sorting Game Files"

mv $(ls | grep -i -e  ".dem"  -e  ".gam"  -e  ".nes"  -e  ".rom"  -e  ".sav") $folder &>/dev/null

;;

11)
echo "Sorting Web Files"

mv $(ls | grep -i -e  ".asp"  -e  ".aspx"  -e  ".cer"  -e  ".cfm"  -e  ".csr"  -e  ".css"  -e  ".htm"  -e  ".html"  -e  ".js"  -e  ".jsp"  -e  ".php"  -e  ".rss"  -e  ".xhtml" ) $folder &>/dev/null

;;

12)
echo "Sorting Folders"

for folder_name in $(ls -d */ | cut -d "/" -f1);
do
	is_special=0
	for i in ${folder_array[@]}; do
		if [[ $folder_name == $i ]]; then
			is_special=1
			break

		fi
	done

	if [[ is_special -eq 0 ]]; then
		mv $folder_name Folders/
	fi

done

;;



esac
}

looper(){
	for path in ${paths_array[@]}; do
		cd $path
		echo "\nSorting path $path\n"
		sort_and_move '1' 'Images/'
		sort_and_move '2' 'Documents/'
		sort_and_move '3' 'Archives/'
		sort_and_move '4' 'Applications/'
		sort_and_move '5' 'Torrents/'
		sort_and_move '6' 'Fonts/'
		sort_and_move '7' 'Videos/'
		sort_and_move '8' 'Music/'
		sort_and_move '9' 'DB_Files/'
		sort_and_move '10' 'Game_Files/'
		sort_and_move '11' 'Web_Files/'
		sort_and_move '12' 'Folders/'

	done
}

#Start cleaning up
looper







