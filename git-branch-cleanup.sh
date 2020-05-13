#!/bin/bash

RED='\033[0;31m'; # Red Color
GREEN='\033[1;32m'; # Green Color
YELLOW='\033[1;33m'; # Yellow Color
BLUE='\033[0;34m'; # Blue Color
CYAN='\033[0;35m'; # Cyan Color
NC='\033[0m'; # No Color

printf "${YELLOW}Checking out master branch. \n"
#git checkout master; 

printf "${BLUE}Pull origin master branch.. \n"
#git pull origin master;

echo -e "${GREEN}Git remote prune... \n"
#git remote prune origin;
#git fetch -p;

echo -e "${RED}Git remove gone brances.... If fails ignore it! \n"
#git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D $1;

echo -e "${BLUE}Get git local branch list :)"
# It will skip the mentioned 
BRANCH_LIST=`git branch | grep -v "master" | grep -v "develop" | grep -v "backup" | grep -v "qa" | grep -v "test";`
#echo "$BRANCH_LIST"

# NOTE: Function needs to be placed first before we call it
function confirm_and_proceed(){
    local br="$1"
    echo -e "${NC}";
	read -p "Are you sure you want to delete '$br'? <Y/N> " prompt
	if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
		then
			git branch -D $br;
		else
  			printf "${GREEN}Skipped: $br \n";
	fi
}

for BRANCH_NAME in $BRANCH_LIST
do
	confirm_and_proceed "$BRANCH_NAME";
done

printf "${BLUE}Done..! \n"

