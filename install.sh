#!/usr/bin/env bash
HOME_DIR=/home/ubuntu
APP_DIR=$HOME_DIR/franca-musicplayer-example/org.franca.examples.musicplayer
SERVER_DIR=$APP_DIR/server_nodejs
TA_DIR_SRC=$HOME_DIR/eb-solys-target-agent
TA_DIR_BINARY=$HOME_DIR/ta_binary


sudo cp -r /vagrant/shell_scripts $HOME_DIR
sudo cp -r /vagrant/eb_solys_scripts $HOME_DIR

# Install the Webservice eco-system - this is clone from another repository
if [ ! -d  $APP_DIR ]; then
	cd $HOME_DIR
    sudo git clone https://github.com/torsten-systemticks/franca-musicplayer-example
fi

# Build and install the target-agent if not already available - this is clone from another repository
if [ ! -d  $TA_DIR_SRC ]; then
	cd $HOME_DIR
    sudo git clone https://github.com/Elektrobit/eb-solys-target-agent.git
	mkdir build
	cd build
	cmake ../ -DTA_PLUGIN_log4j-plugin=true -DTA_PLUGIN_socket-reader-plugin=true -DTA_PLUGIN_resource-monitor-plugin=true -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=$TA_DIR_BINARY
	make all
	make install	
fi


cd $SERVER_DIR
sudo npm install
