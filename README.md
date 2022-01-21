# pre-push-git
Script to add some commands before doing git push command

# About

If you want to add some checks before you do git commit or git push, this will adjust your pre-push and pre-commit git function in few easy steps.

Bash commands from this two files will be run before git commint and git push.

Script will automaticly create pre-push and pre-commit files and you can find and edit this files directly on this locations of your root git directory:

***pre-commit  -   .git/hooks/pre-commit***

***pre-push    -   .git/hooks/pre-push***

This way you can include pre-push-script.sh and pre-push-commands.ini file in your reposatory so that rest of your team can have same pre-commit and pre-push checks
# How to

1. Go to git *root* directory of the project *(where .git directory is)* you want to add pre-commit and pre-push you can clone this repo somewhere and move to your git *root* or from your *root* you can run this command from your terminal:
    ```bash
    $ wget https://github.com/milemik/pre-push-git/blob/main/pre-push-script.sh
    ```
    or
    ```shell
    $ curl https://raw.githubusercontent.com/milemik/pre-push-git/main/pre-push-script.sh --output <some name>.sh
    ```
    This command will download pre-push-script.sh to your current location
    ##### NOTE

2. First run pre-push-script.sh
    ```shell
    $ bash <some name>.sh
    ```

    On first start script will create pre-commit-commands.ini file in your *root* location. In this file you can add your commands as you would run them yourself from terminal
    
    #### EXAMPLE
    ```ini
    [pre-commit]
    "black src/somefile.py" # more info on using black here
    "flake8"

    [pre-push]
    "pytest"
    ```
    ##### NOTE: be sure to suround your commands with quotes and have all dependecies for your commands
3. After you add commands you want to .ini file that is created you need run bash script again. This time pre-commit and pre-push files will be added to .git/hooks directory as explained in ***about*** section
4. Now you should be ready to push some code :D
