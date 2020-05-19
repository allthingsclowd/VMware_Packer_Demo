#!/bin/bash

# Configure Non-Interactive UI to suppress known silent install warnings
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
export TERM=linux

apt-get autoremove -y
apt-get clean

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

df -h

echo "The End!!!"
exit 0