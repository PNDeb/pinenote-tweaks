#!/usr/bin/env sh
# Script used by Github CI to generate Debian images from within the Docker
# container

cd /root/pn_tweaks
git clone https://github.com/PNDeb/pinenote-tweaks.git
cd pinenote-tweaks

# build the handbook
cd pn_handbook
./generate_html.sh
cp -r files/etc/greeter/html /github/home/handbook
cd ..
# handbook end

./build_all.sh
cp -r release /github/home/
ls -l /github/home
