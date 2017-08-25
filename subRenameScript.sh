#!/bin/bash
# GPL Milisav Radivojevic <komodo016@gmail.com>
# subrnm .avi .srt (or vice versa)

if [ $# -ne 2 ]; then
	#echo "USAGE: subrnm .avi .srt (or vice versa)"
	zenity --error --text "You must choose 2 Video and Subtitle files"
	exit 1
fi

# Which is which
filename=$(basename "$1")
extension=${filename##*.}

# Video first
if [ "$extension" == "avi" ] || [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ] || [ "$extension" == "crdownload" ]; then
	#echo "First file is a video"
	subtitles=$(basename "$2")
	extension=${subtitles##*.}
	if [ "$extension" != "srt" ] && [ "$extension" != "sub" ] && [ "$extension" != "txt" ; then
		#echo "First file is a video. Second file are not subtitles"
		zenity --error --text "First file is a video. Second file is not subtitles"
		exit 1
	fi
	filename=${filename%.*}
	dir=$(dirname "$1")
	mv "$2" "$dir/$filename.$extension"
	exit 0
fi

# Subtitles first
if [ "$extension" == "srt" ] || [ "$extension" == "sub" ] || [ "$extension" == "txt" ; then
	#echo "First file are subtitles"
	video=$(basename "$2")
	videext=${video##*.}
	if [ "$videext" != "avi" ] && [ "$videext" != "mp4" ] && [ "$videext" != "mkv" ] && [ "$videext" != "crdownload" ]; then
		#echo "First file are subtitles. Second file in not a video"
		zenity --error --text "First file is subtitle, but second file is not a video"
		exit 1
	fi
	video=${video%.*}
	dir=$(dirname "$2")
	mv "$1" "$dir/$video.$extension"
	exit 0
fi

#echo "USAGE: subrnm .avi .srt (or vice versa)"
zenity --error --text "First file is neither a video or subtitles"
exit 1