#!/bin/bash
#set -x

if [ "$#" -ne 1 ]; then
	echo "usage: $1 <files to transcode>"
	exit 1
fi

if [ ! -r "$1" ]; then
    echo "Cannot read $1"
    exit 1
fi

echo "Starting at: $(date)"

FILELIST=$(realpath "$1")
echo "Reading $FILELIST"

# This is due to my find command and sorting by size
# find /mnt/media/ -size +25G -exec du {} \; | sort -n > # /mnt/media/greater_than_25G_sorted.list
SELECTED=$(head -n1 "$FILELIST" | cut -d'	' -f2)
if [ -z "$SELECTED" ]; then
    echo "No files to select"
    exit 1
fi


INPUTFILE=$SELECTED
OUTPUTFILE=$SELECTED.transcoded.mp4
echo "Selecting '$SELECTED'"

if HandBrakeCLI -i "$INPUTFILE" -o "$OUTPUTFILE" --preset="High Profile"; then
    echo "Completed"
    sed -i -e '1d' "$FILELIST"
else
    echo "Failed"
fi
