#!/bin/bash
#echo "The pull_url is  $1"
pull_url=$1

# Count the number of slashes in the url 

count=$(echo "$pull_url" | tr -cd "/" | wc -c)
#echo "The number of slashes in the string is: " $count
#echo "Count is " $count

if [ $count == 3 ]
then
   #statement1
   # grab the third value of the url
   tail=`echo $pull_url | cut -d"/" -f4`
   # Remove the colon
   repo=`echo "$tail" | sed -r 's/://g'`
else  #if count=2
   # grab the third value of the url
   tail=`echo $pull_url | cut -d"/" -f3`
   # Remove the colon
   repo=`echo "$tail" | sed -r 's/://g'`
fi


retval=$?
if [ "$retval" == 0 ]
then
     echo "$repo"
else
     echo "There was an error running the script"
fi