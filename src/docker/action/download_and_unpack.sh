#!/bin/bash

# Check if the version is provided as an argument
if [ -z "$1" ]; then
    echo "Missing Download Filename"
    exit 1
fi
if [ -z "$2" ]; then
    echo "Missing Download URL"
    exit 1
fi
if [ -z "$3" ]; then
    echo "Token missing"
    exit 1
fi

# Fetch the raw download list
#raw_download_list=$(curl -s "http://downloads.gtnewhorizons.com/ServerPacks/?raw")

# Filter and select the right version with the non-Java8 version
#selected_download=$(echo "$raw_download_list" | grep "/GT_New_Horizons_$1_Server_Java_[0-9]*-[0-9]*.zip" | grep -v "/betas/" | tail -n 1)

#if [ -z "$selected_download" ]; then
#    echo "No matching version found for $1."
#    exit 1
#fi
url=$(echo $2 | tr -d '"')
# Extract the filename from the URL
filename=$(echo $1 | tr -d '"')
tk=$(echo $3 | tr -d '"')
# Download the selected zip file
echo "Filename: '$filename'"
echo "Download_URL: '$url'"
echo "tmp: '$tk'"

echo "Downloading $1..."

curl -L -H "Accept: application/vnd.github+json" \ -H "Authorization: token $tk" \ $url -o "$filename.zip"

# Create the server directory if it doesn't exist
mkdir -p server

# Unpack the zip file into the "server" directory
ls | cat

echo "Unpacking $filename into 'server' directory..."
unzip "$filename.zip" -d "server"

# Set eula.txt to true
echo "eula=true" > server/eula.txt

echo "Done."
exit 0
