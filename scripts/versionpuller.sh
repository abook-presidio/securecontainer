#!/bin/bash
pull_url=$1

# Count the number of slashes in the url
count=$(echo "$pull_url" | tr -cd "/" | wc -c)

if [ $count == 3 ]; then
   # Grab the fourth value of the url
   tail=$(echo $pull_url | cut -d"/" -f4)
elif [ $count == 2 ]; then
   # Grab the third value of the url
   tail=$(echo $pull_url | cut -d"/" -f3)
else
   echo "Unexpected URL format"
   exit 1
fi

# Remove the colon
repo=$(echo "$tail" | sed -r 's/://g')

# Extract the version number and the base name
version=$(echo "$repo" | sed -n 's/.*\([0-9]\{1,\}\.[0-9]\{1,\}\).*/\1/p')

# Check if version is empty and try another pattern
if [ -z "$version" ]; then
   version=$(echo "$repo" | sed -n 's/.*\([0-9]\{1,\}-[a-z0-9_]\{1,\}\).*/\1/p')
fi

base_name=$(echo "$repo" | sed "s/[0-9]\{1,\}\.[0-9]\{1,\}//g" | sed 's/^-//')

# If version is still empty, adjust base_name to exclude the version part
if [ -z "$version" ]; then
   base_name=$(echo "$repo" | sed 's/[0-9]\{1,\}-[a-z0-9_]\{1,\}//g' | sed 's/^-//')
fi

retval=$?
if [ "$retval" == 0 ]; then
     #echo "Base Name: $base_name"
     #echo "Version: $version"
     echo "$base_name $version"
else
     echo "There was an error running the script"
fi
