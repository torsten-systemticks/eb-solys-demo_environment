# eb-solys-demo_environment

## Prerequisites

### Download and install Virtual Box (tested with version 6.0)
https://www.virtualbox.org/wiki/Downloads

### Download and install Vagrant (tested with version 2.2.2)
https://www.vagrantup.com/downloads.html

### Install required vagrant plug-ins
* open a command line and install following plugins, with:
* vagrant plugin install vagrant-hosts
* vagrant plugin install vagrant-share
* vagrant plugin install vagrant-vbguest
* vagrant plugin install vagrant-vbox-snapshot

### Create and run the virtual machine

* Clone or (download and extract) this git repository into a folder of your choice
* Open a shell/commmand line and move to this folder then
* Run "vagrant up && vagrant reload"
* The very first installation could take some minutes, since the virtual machine is built from scratch

### Download and install EB solys

You can download the latest release from here: https://github.com/Elektrobit/eb-solys/releases
Read the main page for detailed how-to documentation: https://github.com/Elektrobit/eb-solys

### Run the Musicplayer Service together with the target agent

* Run the virtual machine with "vagrant up" if not already running
  * Open a shell
  * cd /home/ubuntu/shell_scripts
  * ./startAll.sh
  * (you can also shut it down with ./stopAll.sh)

### Run the Musicplayer Client within EB solys
  * Launch EB solys
  * Import the two scripts located in eb_solys_scripts
  * Run script MusicplayerClient (this creates the built-in Musicplayer Client, as embedded browser)
  * Run script ContractCheckCallback (this connects to your VM)

### Troubleshooting

In some cases the display resolution cannot be set automatically.
In that case you need to set it manually.

* Open a shell and type "xrandr -q" which lists all supported display resolutions
* Look for the one in the list marked with "+" (usually the first in the list) and set it, with e.g. xrandr -s 1920x976
