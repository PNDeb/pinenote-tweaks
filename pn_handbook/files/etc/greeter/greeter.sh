#!/usr/bin/env sh

test -e $HOME/.config/pinenote/disable_greeter && exit

# use gnome-help-based yelp to show the help page
yelp /etc/greeter/html/index.html&

# check for configuration directory
test -d $HOME/.config/pinenote || mkdir $HOME/.config/pinenote

# touching this file will prevent the help from being shown on next boot/login
touch $HOME/.config/pinenote/disable_greeter

# this file should lead the Pinenote GNOME extension to disable the overview
disable_overview_file="$HOME/.config/pinenote/do_not_show_overview"
test -e ${disable_overview_file} && rm "${disable_overview_file}"
