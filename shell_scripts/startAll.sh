#!/bin/bash

cd /home/ubuntu/franca-musicplayer-example/org.franca.examples.musicplayer/server_nodejs

SERVER=node

if pgrep $SERVER 2>/dev/null; then
  echo "Stop a running node server"
  sudo pkill $SERVER
fi

echo "Removing available logs"
sudo rm logs/application.log

echo "Start the server"
sudo $SERVER index.js &

sleep 2s

TA_BIN_DIR=/home/ubuntu/ta_binary
echo "Go to the TA directory"
cd $TA_BIN_DIR
sudo chmod 777 $TA_BIN_DIR

export LD_LIBRARY_PATH=$TA_BIN_DIR:$TA_BIN_DIR/lib

TA=solys-agent

if pgrep $TA 2>/dev/null; then
  echo "Stop a running Target Agent"
  sudo pkill -9 $TA
fi

echo "Start the Target Agent"
./$TA &
