#!/bin/bash


SERVER=node

if pgrep $SERVER 2>/dev/null; then
  echo "Stop a running node server"
  sudo pkill $SERVER
fi

TA=solys-agent

if pgrep $TA 2>/dev/null; then
  echo "Stop a running Target Agent"
  sudo pkill -9 $TA
fi

