# pre-push-git
Script to add some commands before doing git push command

# About

If you want to add some checks before you do push to git this will adjust your pre-push git function in few easy steps.

# How to

1. Go to root of your project dir (where .git directory is)
you can clone this repo somewhere and move to your git root or from your root you can run this command from your terminal:
    ```bash
    $ wget https://github.com/milemik/pre-push-git/blob/main/pre-push-script.sh
    ```
    This command will download pre-push-script.sh to your current location

2. Run pre-push-script.sh
    ```shell
    $ bash pre-push-script.sh
    ```

    On first start script will create pre-commit-commands.ini file in your root location. In this file you can add your commands as you would run them yourself from terminal
    
    #### EXAMPLE
    ```ini
    # your commands here
    black src/somefile.py # more info on using black here
    flake8
    pytest
    ```
    ##### NOTE: be sure to have all dependecies for your commands
3. Run pre-push-script.sh again
4. Try pushing some code :D
