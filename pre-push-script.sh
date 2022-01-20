#!/bin/bash
echo "Creating pre push"

gitdir=".git"
setting_file="pre-push-commands.ini"
new_file="test-pre-push"

git_sample=".git/hooks/pre-push.sample"
git_hooks_dir=".git/hooks/"

if [[ -f $setting_file ]]
then
    echo "Found $setting_file"
else
    echo "Adding $setting_file file to current location"
    touch $setting_file
    echo "# enter your commands here" >> $setting_file
    echo "$setting_file added"
    echo "Please fill in the $setting_file add commands like you would run them from the terminal, one command per line"
    exit
fi

if [[ -d $gitdir ]]
then
	echo "Git directory found!"
	setting=$(cat $setting_file)
	# copy pre-push.sample to new file
	# cp .git/hooks/pre-push.sample test-pre-push
	# echo $setting >> $new_file
	# sed "18a\$setting" < $new_file
	head -n 20 $git_sample > $new_file
	echo "" >> $new_file
	echo "# ==================================================================" >> $new_file
	echo "# Your commands came here" >> $new_file
	echo "# PLEASE BE SHURE THAT YOU HAVE ALL DEPENDECIES FOR YOUR COMMANDS" >> $new_file
	echo "" >> $new_file
	echo "set -e" >> $new_file
	cat $setting_file >> $new_file
	echo "# End of your custom commands" >> $new_file
	echo "# ==================================================================" >> $new_file
	tail -n +21  $git_sample >> $new_file
	echo "Copy file to $git_hooks_dir"
	cp $new_file "$git_hooks_dir/pre-push"
	chmod +x "$git_hooks_dir/pre-push"
else
	echo "Git dir found $gitdir"
	exit 0

fi
