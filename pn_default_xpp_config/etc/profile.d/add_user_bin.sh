# add $HOME/bin to PATH if not present
HOMEBIN="$HOME/bin"
if [[ ! $PATH =~ "$HOMEBIN" ]]; then
	export PATH=$PATH:$HOMEBIN
fi

