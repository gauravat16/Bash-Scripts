#!/bin/bash
repoFile="repos.txt"
username="gaurav"


mkdir /Users/gaurav/git_$username
cd git_$username

cd /Users/gaurav

while read -r line || [[ -n "$line" ]];do
	echo "$line"
	repoName=$(echo "$line" | cut -d',' -f1)
	branch=$(echo "$line" | cut -d',' -f2)
	url=$(echo "$line" | cut -d',' -f3)
	mkdir /Users/gaurav/git_$username/$repoName
	cd /Users/gaurav/git_$username/$repoName
	git init
	echo "Directory is $PWD"
	git remote rm origin
	git remote add -t $branch -f origin $url
	git checkout $branch
	cd /Users/gaurav

done <$repoFile