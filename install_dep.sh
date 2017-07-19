#!/usr/bin/env bash
HOME_DIR=/home/ubuntu
APP_DIR=$HOME_DIR/franca-musicplayer-example/org.franca.examples.musicplayer
SERVER_DIR=$APP_DIR/server_nodejs
CLIENT_DIR=$APP_DIR/client
TMP_DIR=$HOME_DIR/unversioned
TA_DIR=$HOME_DIR/ta

# Only install something if a certain file is missing.
if [ ! -d  $APP_DIR ]; then
    sudo git clone https://github.com/kbirken/franca-musicplayer-example
fi

# Unzip target agent if install directory is empty
if [ ! -d  $TA_DIR/install ]; then
    cd $TA_DIR
    sudo tar -xvf ebsolys-target-agent-linux-x86-64-17.25.tar.gz
    sudo cp conf.xml $TA_DIR/install/
fi

sudo mkdir -p $SERVER_DIR/gen/org/example/
sudo mkdir -p $CLIENT_DIR/gen/org/example/
sudo mv $TMP_DIR/SpotifyApiCredentials.js $SERVER_DIR/credentials/
sudo mv $TMP_DIR/MusicplayerProxy.js $CLIENT_DIR/gen/org/example/
sudo mv $TMP_DIR/MusicplayerStub.js $SERVER_DIR/gen/org/example/

sudo rm -r -f $TMP_DIR

cd $SERVER_DIR
sudo npm install
