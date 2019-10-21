#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable Ctrl-s and Ctrl-q
stty -ixon

# cd automatically
shopt -s autocd

# Infinite history
HISTSIZE='' HISTFILESIZE=''

# VI mode
set -o vi

LS_COLORS=$LS_COLORS:'di=0;36:' ; export LS_COLORS

source "$HOME/.aliases"

# Various program settings
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export QUTEWAL_DYNAMIC_LOADING=True

# Utility functions
m() {
	man -k "^$@$" >/dev/null && man -Tpdf "$@" | zathura - ;
}

vf() {
	fzf | xargs -r $EDITOR
}

zf() {
	cat \
		<(find "$HOME/Dropbox/docs" -name '*.pdf') \
		<(find "$HOME/Dropbox/docs" -name '*.ps') \
		| fzf \
		| xargs -r zathura ;
}

t() {
	[ "${TERM:-none}" != "linux" ] && return 0

	scr="$(ls $HOME/.scripts/tty | fzf --height=8)"
	[ -z "$scr" ] && return 0

	$HOME/.scripts/tty/$scr
}

# Load wal colors to be used by some scripts
. /home/brendan/.cache/wal/colors.sh

# Print a nice display when the session starts
ufetch

# Set PS1 for a pretty(er) terminal
# export PS1="\n\[$(tput bold)\][\[$(tput sgr0)\]\[\033[34m\]\u\[$(tput sgr0)\]\[\033[37m\]@\[$(tput sgr0)\]\[\033[34m\]\h\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[31m\]\$?\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[32m\]\W\[$(tput sgr0)\]\[\033[37m\]]\[$(tput sgr0)\]\\n\\$\[$(tput sgr0)\] "
export PS1="\n\[$(tput bold)\]{\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;14m\]\u@\h\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]}\[$(tput sgr0)\] {\[$(tput sgr0)\]\[\033[38;5;1m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]} {\[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]}\\n\\$\[$(tput sgr0)\] "
