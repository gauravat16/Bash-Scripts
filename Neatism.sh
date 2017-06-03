#!/bin/bash	
echo "Neatism - For nerds with OCD"
figlet Neatism - For nerds with OCD

#Adds Underscore for every space in file name

for f in *\ *; do mv "$f" "${f// /_}"; done &>/dev/null



sort_and_move(){
caseVal=$1
folder=$2

mkdir $folder &>/dev/null
case $caseVal in
	1 )
echo "Sorting Images"
mv $(ls | grep  -e ".BMP" -e ".bmp" -e ".DDS" -e ".dds" -e ".GIF" -e ".gif" -e ".JPG" -e ".jpg" -e ".PNG" -e ".png" -e ".PSD" -e ".psd" -e ".PSPIMAGE" -e ".pspimage" -e ".TGA" -e ".tga" -e ".THM" -e ".thm" -e ".TIF" -e ".tif" -e ".TIFF" -e ".tiff" -e ".YUV" -e ".yuv"  -e ".AI" -e ".ai" -e ".EPS" -e ".eps" -e ".PS" -e ".ps" -e ".SVG" -e ".svg") $folder &>/dev/null

;;

2)
echo "Sorting Documents"

mv $(ls | grep -e ".CSV" -e ".csv" -e ".DAT" -e ".dat" -e ".GED" -e ".ged" -e ".KEY" -e ".key" -e ".KEYCHAIN" -e ".keychain" -e ".PPS" -e ".pps" -e ".PPT" -e ".ppt" -e ".PPTX" -e ".pptx" -e ".SDF" -e ".sdf" -e ".TAR" -e ".tar" -e ".TAX2016" -e ".tax2016" -e ".VCF" -e ".vcf" -e ".XML" -e ".xml") $folder &>/dev/null
mv $(ls | grep -e ".DOC" -e ".doc" -e ".DOCX" -e ".docx" -e ".LOG" -e ".log" -e ".MSG" -e ".msg" -e ".ODT" -e ".odt" -e ".PAGES" -e ".pages" -e ".RTF" -e ".rtf" -e ".TEX" -e ".tex" -e ".TXT" -e ".txt" -e ".WPD" -e ".wpd" -e ".WPS" -e ".wps") $folder &>/dev/null
mv $(ls | grep -e ".pdf" -e ".doc" -e ".xls" -e ".ppt" -e ".pptx" -e ".ppt"  -e ".INDD" -e ".indd" -e ".PCT" -e ".pct" -e ".PDF" -e ".pdf"  -e ".XLR" -e ".xlr" -e ".XLS" -e ".xls" -e ".XLSX" -e ".xlsx") $folder &>/dev/null


;;

3)
echo "Sorting Archives"

mv $(ls | grep -e ".7Z" -e ".7z" -e ".CBR" -e ".cbr" -e ".DEB" -e ".deb" -e ".GZ" -e ".gz" -e ".PKG" -e ".pkg" -e ".RAR" -e ".rar" -e ".RPM" -e ".rpm" -e ".SITX" -e ".sitx" -e ".TAR.GZ" -e ".tar.gz" -e ".ZIP" -e ".zip" -e ".ZIPX" -e ".zipx" -e ".BIN" -e ".bin" -e ".CUE" -e ".cue" -e ".DMG" -e ".dmg" -e ".ISO" -e ".iso" -e ".MDF" -e ".mdf" -e ".TOAST" -e ".toast" -e ".VCD" -e ".vcd") $folder &>/dev/null

;;

4)
echo "Sorting Applications"

mv $(ls | grep  -e ".APK" -e ".apk" -e ".APP" -e ".app" -e ".BAT" -e ".bat" -e ".CGI" -e ".cgi" -e ".COM" -e ".com" -e ".EXE" -e ".exe" -e ".GADGET" -e ".gadget" -e ".JAR" -e ".jar" -e ".WSF" -e ".wsf") $folder &>/dev/null

;;

5)
echo "Sorting Torrents"

mv $(ls | grep -e ".torrent") $folder &>/dev/null

;;

6)
echo "Sorting Fonts"

mv $(ls | grep -e ".FNT" -e ".fnt" -e ".FON" -e ".fon" -e ".OTF" -e ".otf" -e ".TTF" -e ".ttf") $folder &>/dev/null

;;

7)
echo "Sorting Videos"

mv $(ls | grep -e ".3G2" -e ".3g2" -e ".3GP" -e ".3gp" -e ".ASF" -e ".asf" -e ".AVI" -e ".avi" -e ".FLV" -e ".flv" -e ".M4V" -e ".m4v" -e ".MOV" -e ".mov" -e ".MP4" -e ".mp4" -e ".MPG" -e ".mpg" -e ".RM" -e ".rm" -e ".SRT" -e ".srt" -e ".SWF" -e ".swf" -e ".VOB" -e ".vob" -e ".WMV" -e ".wmv") $folder &>/dev/null
mv $(ls | grep -e ".3DM" -e ".3dm" -e ".3DS" -e ".3ds" -e ".MAX" -e ".max" -e ".OBJ" -e ".obj") $folder &>/dev/null
;;

8)
echo "Sorting Music"
mv $(ls | grep -e ".AIF" -e ".aif" -e ".IFF" -e ".iff" -e ".M3U" -e ".m3u" -e ".M4A" -e ".m4a" -e ".MID" -e ".mid" -e ".MP3" -e ".mp3" -e ".MPA" -e ".mpa" -e ".WAV" -e ".wav" -e ".WMA" -e ".wma") $folder &>/dev/null


;;

9)
echo "Sorting Database Files"

mv $(ls | grep  -e ".ACCDB" -e ".accdb" -e ".DB" -e ".db" -e ".DBF" -e ".dbf" -e ".MDB" -e ".mdb" -e ".PDB" -e ".pdb" -e ".SQL" -e ".sql") $folder &>/dev/null

;;

10)
echo "Sorting Game Files"

mv $(ls | grep -e ".DEM" -e ".dem" -e ".GAM" -e ".gam" -e ".NES" -e ".nes" -e ".ROM" -e ".rom" -e ".SAV" -e ".sav") $folder &>/dev/null

;;

11)
echo "Sorting Web Files"

mv $(ls | grep -e ".ASP" -e ".asp" -e ".ASPX" -e ".aspx" -e ".CER" -e ".cer" -e ".CFM" -e ".cfm" -e ".CSR" -e ".csr" -e ".CSS" -e ".css" -e ".HTM" -e ".htm" -e ".HTML" -e ".html" -e ".JS" -e ".js" -e ".JSP" -e ".jsp" -e ".PHP" -e ".php" -e ".RSS" -e ".rss" -e ".XHTML" -e ".xhtml") $folder &>/dev/null

;;



esac
}

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










