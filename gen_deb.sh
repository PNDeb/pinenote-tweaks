#!/usr/bin/env sh
# Script used by Github CI to generate Debian images from within the Docker
# container

cd /root/pn_tweaks
git clone https://github.com/PNDeb/pinenote-tweaks.git
cd pinenote-tweaks
./build_all.sh
cp -r release /github/home/
ls -l /github/home
