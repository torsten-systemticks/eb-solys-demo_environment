#!/usr/bin/env bash
HOME_DIR=/home/ubuntu
APP_DIR=$HOME_DIR/franca-musicplayer-example/org.franca.examples.musicplayer
SERVER_DIR=$APP_DIR/server_nodejs
CLIENT_DIR=$APP_DIR/client
TMP_DIR=$HOME_DIR/unversioned

# Only install something if a certain file is missing.
if [ ! -d  $APP_DIR ]; then
    sudo git clone https://github.com/kbirken/franca-musicplayer-example
fi

sudo mkdir -p $SERVER_DIR/gen/org/example/
sudo mkdir -p $CLIENT_DIR/gen/org/example/
sudo mv $TMP_DIR/SpotifyApiCredentials.js $SERVER_DIR/credentials/
sudo mv $TMP_DIR/MusicplayerProxy.js $CLIENT_DIR/gen/org/example/
sudo mv $TMP_DIR/MusicplayerStub.js $SERVER_DIR/gen/org/example/

sudo rm -r -f $TMP_DIR

cd $SERVER_DIR
sudo npm install
