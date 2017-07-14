# eb-solys-demo_environment

## Prerequisites

### Download and install Virtual Box (tested with version 5.1.22)
https://www.virtualbox.org/wiki/Downloads

### Download and install Vagrant (tested with version 1.9.5)
https://www.vagrantup.com/downloads.html
Goto Download older versions and select version 1.9.5

### Install required vagrant plug-ins
* open a command line and install following plugins, with:
* vagrant plugin install vagrant-hosts
* vagrant plugin install vagrant-share
* vagrant plugin install vagrant-vbguest
* vagrant plugin install vagrant-vbox-snapshot

### Create and run the virtual machine

* Clone or (download and extract) this git repository into a folder of your choice
* Open a shell/commmand line and move to this folder then
* Run vagrant up
* The very first installation could take some minutes, since the virtual machine is built from scratch
* If the virtual machine does not start up in GUI mode, just ender "vagrant reload"

### Run the demo app

* Run the virtual machine with "vagrant up" if not already running
* Run the server
  * Open a shell
  * cd /home/ubuntu/franca-musicplayer-example/org.franca.examples.musicplayer/server_nodejs
  * sudo node index.js

* Run the client
  * Open firefox
  * Enter "localhost:8180" as URL
  * Enter a title and press "Find"

You finally should see s.th. like this:

![Alt text](/doc/vm_screenshot.png?raw=true "Screenshot from application")

### Troubleshooting

In some cases the display resolution cannot be set automatically.
In that case you need to set it manually.

* Open a shell and type "xrandr -q" which lists all supported display resolutions
* Look for the one in the list marked with "+" (usually the first in the list) and set it, with e.g. xrandr -s 1920x976
