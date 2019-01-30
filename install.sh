#!/usr/bin/env bash
HOME_DIR=/home/ubuntu
APP_DIR=$HOME_DIR/franca-musicplayer-example/org.franca.examples.musicplayer
SERVER_DIR=$APP_DIR/server_nodejs

sudo cp -r /vagrant/shell_scripts $HOME_DIR
sudo cp -r /vagrant/eb_solys_scripts $HOME_DIR

# Only install something if a certain file is missing.
if [ ! -d  $APP_DIR ]; then
	cd $HOME_DIR
    sudo git clone https://github.com/torsten-systemticks/franca-musicplayer-example
fi

cd $SERVER_DIR
sudo npm install
