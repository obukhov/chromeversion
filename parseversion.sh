#!/bin/bash

OLDIFS=$IFS
IFS=','

major_version=""
releases_csv=$(curl -s http://omahaproxy.appspot.com/all)

while read -r os channel current_version previous_version
do
    if [[ "$os" == "linux" && "$channel" == "stable" ]]
    then
      major_version="$(cut -d '.' -f 1 <<< $current_version)"
      break
    fi
done <<< "$releases_csv"

IFS=$OLDIFS

if [[ "$major_version" == "" ]]
then
    exit 1
else
    echo $major_version
fi