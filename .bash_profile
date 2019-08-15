# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# If on TTY1, start xserver and dwm
if [ "$(tty)" == "/dev/tty1" ]; then
	pgrep dwm || exec startx ;
fi


if [ "$TERM" = "linux" ]; then
	# Solarized Dark
#     echo -en "\e]PB263238" # S_base00
#     echo -en "\e]PA586e75" # S_base01
#     echo -en "\e]P0073642" # S_base02
#     echo -en "\e]P62aa198" # S_cyan
#     echo -en "\e]P8002b36" # S_base03
#     echo -en "\e]P2859900" # S_green
#     echo -en "\e]P5d33682" # S_magenta
#     echo -en "\e]P1dc322f" # S_red
#     echo -en "\e]PC839496" # S_base0
#     echo -en "\e]PE93a1a1" # S_base1
#     echo -en "\e]P9cb4b16" # S_orange
#     echo -en "\e]P7eee8d5" # S_base2
#     echo -en "\e]P4268bd2" # S_blue
#     echo -en "\e]P3b58900" # S_yellow
#     echo -en "\e]PFfdf6e3" # S_base3
#     echo -en "\e]PD6c71c4" # S_violet

	# Base16-Material
	echo -en "\e]P0263238"
	echo -en "\e]P1F07178"
	echo -en "\e]P2C3E88D"
	echo -en "\e]P3FFCB6B"
	echo -en "\e]P482AAFF"
	echo -en "\e]P5C792EA"
	echo -en "\e]P689DDFF"
	echo -en "\e]P7EEFFFF"
	echo -en "\e]P8546E7A"
	echo -en "\e]P9F07178"
	echo -en "\e]PAC3E88D"
	echo -en "\e]PBFFCB6B"
	echo -en "\e]PC82AAFF"
	echo -en "\e]PDC792EA"
	echo -en "\e]PE89DDFF"
	echo -en "\e]PFFFFFFF"

    clear # against bg artifacts
fi

setfont -24 /usr/share/consolefonts/ter-powerline-v24n.psf.gz
