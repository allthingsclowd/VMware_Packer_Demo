#!/usr/bin/env bash

# Configure Non-Interactive UI to suppress known silent install warnings
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
export TERM=linux

sudo apt-get install -y perl open-vm-tools

# Hack to fix ubuntu 18.04 linux customisations bug
tmpfile=/tmp/bananas
sudo cp /lib/systemd/system/open-vm-tools.service ${tmpfile} &&
awk '/Unit/ { print; print "After=dbus.service"; next }1' ${tmpfile} | sudo tee /lib/systemd/system/open-vm-tools.service > /dev/null
sudo rm ${tmpfile}

sudo sed -i "s/D \/tmp 1777 root root -/#D \/tmp 1777 root root -/"  /usr/lib/tmpfiles.d/tmp.conf

sudo systemctl restart open-vm-tools

exit 0