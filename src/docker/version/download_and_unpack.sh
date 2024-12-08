#!/bin/bash

# Check if the version is provided as an argument

#param 1 Version with beta tag
if [ -z "$1" ]; then
    echo "Missing Version"
    exit 1
fi
#param 2 beta?
if [ -z "$2" ]; then
    echo "Missing beta boolean"
    exit 1
fi

baseurl="downloads.gtnewhorizons.com/ServerPacks/"

if [ "$2" == "true" ]; then
    baseurl="${baseurl}betas/"
fi

#versionbase="GT_New_Horizons_${1}_Server_Java_17"

# Fetch the raw download list
raw_download_list=$(curl -s "${baseurl}?raw")
version=$(echo "$1" | tr -d '"')
# Filter and select the right version with the non-Java8 version
selected_download=$(echo "$raw_download_list" | grep "GT_New_Horizons_${version}_Server_Java_[0-9]*-[0-9]*.zip" | tail -n 1)

if [ -z "$selected_download" ]; then
    echo "No matching version found for $1."
    exit 1
fi

filename="GTNH_Server.zip"

# Extract the filename from the URL
# Download the selected zip file
echo "Filename: '$filename'"
echo "Download_URL: '$selected_download'"

echo "Downloading $filename..."

curl -o "/tmp/$filename" $selected_download
# Create the server directory if it doesn't exist
mkdir -p server

# Unpack the zip file into the "server" directory
ls | cat

echo "Unpacking $filename into 'server' directory..."

unzip "/tmp/$filename" -d "server/"


#Transform String due to to filename is completely lowercase but the extracted GTNH is in UPPERCASE

ls server | cat
ls /app/server | cat

chmod +x /app/server/startserver-java9.sh




# Set eula.txt to true
echo "eula=true" > server/eula.txt


echo "Done."
exit 0
