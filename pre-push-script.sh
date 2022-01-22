#!/bin/bash

gitdir=".git"
setting_file="pre-push-commands.ini"
push_file="pre-push-local"
commit_file="pre-commit-local"

git_hooks_dir=".git/hooks/"

# Files that git uses for pre-commit and pre-push
git_pre_commit_file="$git_hooks_dir/pre-commit"
git_pre_push_file="$git_hooks_dir/pre-push"

# COMMANDS FOR CHECK WHICH COMMAND GOES TO WHICH FILE
# based on the .ini file with commands
commit_line="[pre-commit]"
push_line="[pre-push]"
check=0


# DELETE ALL PRE-PUSH-GIT FILES EVEN THIS FILE!
if [[ $1 == "-d" ]]
then
	echo "Removing pre-push-git files"
	if [[ -f $git_pre_commit_file ]]
	then
		echo "Removing $git_pre_commit_file"
		rm $git_pre_commit_file
	fi
	
	if [[ -f $git_pre_push_file ]]
	then
		echo "Removing $git_pre_push_file"
		rm $git_pre_push_file
	fi

	if [[ -f $setting_file ]]
	then
		echo "Removing $setting_file"
		rm $setting_file
	fi

	rm "pre-test.sh"
	echo "All files removed"
	exit
fi

echo "Creating pre push"

if [[ -f $setting_file ]]
then
    echo "Found $setting_file"
else
    echo "Adding $setting_file file to current location"
    touch $setting_file
	echo "[pre-commit]" >> $setting_file
    echo "" >> $setting_file
    echo "" >> $setting_file
    echo "[pre-push]" >> $setting_file
    echo "" >> $setting_file
    echo "$setting_file added"
    echo "Please fill in the $setting_file add commands like you would run them from the terminal, one command per line"
    exit
fi

if [[ -d $gitdir ]]
then
	# SET-PRE-PUSH
	echo "Git directory found!"
	setting=$(cat $setting_file)
	echo "# ==================================================================" >> $push_file
	echo "# Your commands came here" >> $push_file
	echo "# PLEASE BE SHURE THAT YOU HAVE ALL DEPENDECIES FOR YOUR COMMANDS" >> $push_file
	echo "" >> $push_file
	echo "set -e" >> $push_file
	# ADD COMMANDS TO pre-push file
	eval "arr=($setting)"
	for s in "${arr[@]}";
	do
		if [[ $s == "$commit_line" ]]
		then
			check=0
		elif [[ $s == "$push_line" ]]
		then
			check=1
		else
			if [[ $check -eq 1 ]]
			then
				echo "Adding $s command to pre-push"
				echo "$s" >> $push_file
			fi
		fi
	done
	echo "# End of your custom commands" >> $push_file
	echo "# ==================================================================" >> $push_file
	echo "Copy file to $git_hooks_dir"
	cp $push_file $git_pre_push_file
	chmod +x $git_pre_push_file
	rm $push_file

	# SET PRE-COMMIT
	echo "" >> $commit_file
	echo "# ==================================================================" >> $commit_file
	echo "# Your commands came here" >> $commit_file
	echo "# PLEASE BE SHURE THAT YOU HAVE ALL DEPENDECIES FOR YOUR COMMANDS" >> $commit_file
	echo "" >> $commit_file
	echo "set -e" >> $commit_file
	# ADD COMMANDS TO pre-push file
	eval "arr=($setting)"
	for s in "${arr[@]}";
	do
		if [[ $s == "$commit_line" ]]
		then
			check=0
		elif [[ $s == "$push_line" ]]
		then
			check=1
		else
			if [[ $check -eq 0 ]]
			then
				echo "Adding $s command to pre-commit"
				echo "$s" >> $commit_file
			fi
		fi
	done
	echo "# End of your custom commands" >> $commit_file
	echo "# ==================================================================" >> $commit_file
	echo "Copy file to $git_hooks_dir"
	cp $commit_file $git_pre_commit_file
	chmod +x $git_pre_commit_file
	rm $commit_file
else
	echo "Git dir found $gitdir"
	exit 0

fi
