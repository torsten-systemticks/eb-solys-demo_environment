# eb-solys-demo_environment

## Prerequisites

### Download and install Virtual Box (tested with version 5.1.22)
https://www.virtualbox.org/wiki/Downloads

### Download and install Vagrant (tested with version 1.9.5)
https://www.vagrantup.com/downloads.html
Goto Download older versions and select version 1.9.5

### Install required vagrant plug-ins
* vagrant plugin install vagrant-hosts
* vagrant plugin install vagrant-share
* vagrant plugin install vagrant-vbguest
* vagrant plugin install vagrant-vbox-snapshot

### Create and run the virtual machine

* Clone this git repository into a folder of your choice
* Open a shell/commmand line and move to this folder then
* Run vagrant up

### Run the demo app

* Run the server
  * Open a shell 
  * cd /home/ubuntu/franca-musicplayer-example/org.franca.examples.musicplayer/server_nodejs
  * sudo node index.js

* Run the client
  * Open firefox
  * Enter "localhost:8180" as URL

### Troubleshooting




