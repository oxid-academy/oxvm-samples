#!/bin/bash -e

THEMEDIR=/vagrant/oxideshop/source/application/views/flow/



# Run once
if [[ $1 == "onetimeinit" ]];
  then
    echo
    echo One-time init

    cd /vagrant

    # Add 'execute' flag
    chmod +x ./deploy/locally.sh

    # NPM: update
    #echo
    #echo Updating NPM...
    #sudo npm install -g npm
    #sudo npm install -g grunt-cli

    # create a directory within the vm for npm
    # it will later be used instead of the shared folder, so npm will be faster and does not have symlinks problems in windows
    cd ${THEMEDIR}
    sudo rm -rf node_modules
    mkdir -p node_modules
    mkdir -p ~/node_modules

    cd /vagrant/

    # Call init
    ./deploy/locally.sh init
fi



# (Re-)Install dependencies
if [[ $1 == "init" ]];
  then

    cd /vagrant/

    echo
    echo Installing project dependencies...

    if mount | grep ~/node_modules > /dev/null; then
       echo "node_modules" is folder already mounted, ok
    else
       echo mounting node modules to be local, to avoid problems with shared folder
       # -> problem can be symlink support in Windows, maximum file length, file access rights ....
       if [ ! -d ~/node_modules ]; then
           mkdir ~/node_modules
       fi
       if [ ! -d ${THEMEDIR}node_modules ]; then
           mkdir ${THEMEDIR}node_modules
       fi
       sudo mount --bind ~/node_modules ${THEMEDIR}node_modules
    fi

    # NPM: Install (package.json)
    #echo
    #echo Installing via NPM...
    #cd ${THEMEDIR}
    #npm install --no-bin-links

    cd /vagrant/

    # Composer: Install modules
    echo
    echo 'Installing via Composer (OXID eShop)...'
    cd oxideshop
    if [ ! -d vendor ]; then
        mkdir vendor
    fi
    sudo chown -R vagrant.vagrant vendor
	cd /vagrant/oxideshop/source
    php ../../composer.phar install    


    echo 'Installing via Composer (modules)...'
    cd /vagrant/oxideshop/source/modules
    php ../../../composer.phar install

    cd /vagrant/

    # Take off
    ./deploy/locally.sh takeoff
    exit
fi



# Refresh composer setup
if [[ $1 == "refresh" ]];
  then
    echo
    echo Refreshing...

    cd /vagrant/

    rm oxideshop/vendor -rf
    rm oxideshop/source/modules/vendor -rf
    rm ~/.npm/ -rf
    sudo rm ~/.config/configstore -rf
    rm ${THEMEDIR}/node_modules -rf

    # Goto Init
    ./deploy/locally.sh init
    exit
fi



# Refresh database
if [[ $1 == "resetdb" ]];
  then
    sudo rm /var/tmp/* -rf
    cd /vagrant/
    echo
    echo Resetting database . . .
    echo
    echo Overwriting existing database . . .
    mysql -uroot -proot oxid < sql/db.sql

    # Take off
    ./deploy/locally.sh takeoff
    exit
fi




# "Take off" mode. Do what is necessary to prepare the project after switching branches.
if [[ $1 == "takeoff" ]];
  then
    # Call with "continue" as $2, to skip exit command.
    ./deploy/locally.sh migrate continue

    # Compile frontend resources
    #./deploy/locally.sh resources
    exit
fi

#  Prepare the OXID eShop using OXID console for fix commands and migrations.
if [[ $1 == "migrate" ]];
  then
    echo
    echo Getting the shop ready . . .
    cd /vagrant/

    php oxideshop/source/oxid cache:clear
    php oxideshop/source/oxid migrate
    php oxideshop/source/oxid db:update
    php oxideshop/source/oxid config:import
    php oxideshop/source/oxid fix:states --all
    php oxideshop/source/oxid cache:clear

    # In order to continue, add a second parameter
    if [[ !$2 ]];
      then
        exit
    fi
fi

## Help
if [[ $1 == "help" ]];
  then
    clear
    echo
    echo './deploy/locally.sh Parameters Overview'

    echo
    echo takeoff
    echo '    Get the project ready. Takes a while. Recommended when after switching branches on Git. Runs into "resources" afterwards.'

    echo
    echo migrate
    echo '    Re-register modules, migrate the database, import config.'

    echo
    echo resources
    echo '    (N/A)'

    echo
    echo quick
    echo '    (N/A)'

    echo
    echo resetdb
    echo '    Destroys the existing database and launches a full build. Recommended when trying out new migrations or after data modification.'

    echo
    echo init, onetimeinit
    echo '    Triggers NPM and composer to install required dependencies. Runs into "takeoff" afterwards.'

    echo
    echo refresh
    echo '    Deletes existing resources downloaded by NPM and Composer. Runs into "init" afterwards.'

    echo
    echo help
    echo '    You are already here.'

    echo
    exit
fi

# Fallback
if [[ $1 == "" ]];
  then
    echo
    echo 'No mode selected, assuming TAKEOFF'
    ./deploy/locally.sh takeoff
    exit
fi

echo
echo --------------------------------
echo 'Preparation done. :-)';
echo Before you commit changes you might want to export config configuration by php oxid config:export
echo and check or clear the generated configuration files in oxideshop/configurations/.
echo
echo 'Type "./deploy/locally.sh help" to learn more about options.';
echo
