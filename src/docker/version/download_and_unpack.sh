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

baseurl="https://downloads.gtnewhorizons.com/ServerPacks/"

echo "arg2=[$2]" | cat -A
beta=$(echo "$2" | tr -d '"')

#if [[ "${beta,,}" == "true" ]]; then
#    baseurl="${baseurl}betas/"
#fi

#versionbase="GT_New_Horizons_${1}_Server_Java_17"
# Fetch the raw download list
raw_download_list=$(curl -s "https://downloads.gtnewhorizons.com/versions.json")
version=$(echo "$1" | tr -d '"')
# Filter and select the right version with the non-Java8 version
server_pack_url=$(echo "$raw_download_list" | jq -er --arg version "$version" '.[$version].server.java17_2XUrl')
echo "$server_pack_url"


#selected_download=$(echo "$raw_download_list" | grep "GT_New_Horizons_${version}_Server_Java_[0-9]*-[0-9]*.zip" | tail -n 1)
#selected_download=$(echo "${baseurl}GT_New_Horizons_${version}_Server_Java_17-25.zip" | tail -n 1)
selected_download=$server_pack_url
http_code=$(curl -s -o /dev/null -w "%{http_code}" "$selected_download")

if [ "$http_code" != "200" ]; then
    echo "ERROR: File not found ($http_code): $selected_download"
    exit 1
fi

filename="GTNH_Server.zip"

# Extract the filename from the URL
# Download the selected zip file
echo "Filename: '$filename'"
echo "Download_URL: '$selected_download'"

echo "Downloading $filename..."

curl -fL --retry 3 -o "/tmp/$filename" $selected_download
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
