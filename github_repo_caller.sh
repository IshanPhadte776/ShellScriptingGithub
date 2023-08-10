#!/bin/bash
#Program to make a Github Rest API Call and gt all data about a repo
# Arguments can be the $githubAPIToken and /repos/IshanPhadte776/PersonalReactWebsite
#Makes Sure we are working with 2 arguments
if [ ${#@} -lt 2 ]; then
   echo "usage: $0 [GithubToken] [Rest]"
   exit 1;
fi

#Sets up Variables
GITHUB_TOKEN=$1
GITHUB_API_REST=$2

#Sets up a header for json responses
GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

#Create a temp file (For large data)
temp=`basename $0`
TMPFILE=`mktemp /tmp/${temp}.XXXXXX` || exit 1

#Function for Rest Call and store result in a temp file
function rest_call {
        #curl is for transferring data
        curl -s $1 -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" >> $TMPFILE
}
#Determines the last page
#last_page=`curl -s -I "https://api.github.com${GITHUB_API_REST}" -H "${GITHUB_API_HEADER_ACCEPT}" | grep '^Link:'| sed -e 's/^Link:.*page=//g' -e 's/>.*$//g'`
#If we are working with multiple pages
#if [ -z "$last_page" ]; then
#       rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
#else
#       for p in `seq 1 $last_page`; do
#               rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
        #done

rest_call "https://api.github.com${GITHUB_API_REST}"

#Print Temp File
cat "$TMPFILE"
