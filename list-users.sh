#!/bin/bash
#
#GitHubApi URL

API_URL="https://api.github.com"

#Github username and access_token 

USERNAME=$username
TOKEN=$token

#repo owner and repository information

REPO_OWNER=$1
REPO_NAME=$2
echo "USERNAME: $USERNAME"
echo "TOKEN: $TOKEN"
echo "REPO_OWNER: $REPO_OWNER"
echo "REPO_NAME: $REPO_NAME"

#function to make get request to github

function github_api_get(){
 local endpoint="$1"
 local url="${API_URL}/${endpoint}"

 #send api request to url with authentication  
 
 curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

#function to list users onto terminal
function list_users_with_read_access() {
 local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

 #fetching all the collaborators on the repo
 collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

 #display collaborators
 if [[ -z "$collaborators" ]]; then
	 echo "No users available with read access for repo ${REPO_OWNER}/{$REPO_NAME}."
 else
	 echo "Users with read permission to ${REPO_OWNER}/${REPO_NAME}."
	 echo "$collaborators"
 fi
} 

list_users_with_read_access








