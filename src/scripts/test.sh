#!/bin/bash

WF_ID=11925966414

echo "$WF_ID"

response=$(curl -s \
    "https://api.github.com/repos/GTNewHorizons/DreamAssemblerXXL/actions/runs/$WF_ID")
artifacts=$(curl -S \
    "https://api.github.com/repos/GTNewHorizons/DreamAssemblerXXL/actions/runs/$WF_ID/artifacts")

serverartifact=$(echo "$artifacts" | jq '.artifacts.[] | select(.name | contains("server-new-java"))'
)
filename=$(echo "$serverartifact" | jq '.name' )

downloadpath=$(echo "$serverartifact" | jq '.archive_download_url')

date=$(echo "$filename" | grep -oP '\d{4}-\d{2}-\d{2}')
version=$(echo "$filename" | grep -oP '(?<=\+)\d+')

echo "$serverartifact"

hashlong=$(echo "$serverartifact" | jq '.workflow_run.head_sha')

echo "Hash: $hashlong"

echo "Filename : $filename"

echo "Download Path : $downloadpath"

echo "D:   $date"
echo "V:   $version"
echo "D+V: $date+$version"


curl -L $downloadpath
#curl -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" $downloadpath
