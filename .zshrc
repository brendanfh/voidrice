# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ $- != *i* ]] && return

# Path to your oh-my-zsh installation.
export ZSH="/home/brendan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(git tmux zsh-autosuggestions colorize zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

LS_COLORS=$LS_COLORS:'di=0;36:' ; export LS_COLORS

source ~/.aliases

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
	ls *.pdf \
		| fzf \
		| xargs -r zathura ;
}

t() {
	[ "${TERM:-none}" != "linux" ] && return 0

	scr="$(ls $HOME/.scripts/tty | fzf --height=8)"
	[ -z "$scr" ] && return 0

	$HOME/.scripts/tty/$scr
}

rangercd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
bindkey -s '^p' 'rangercd\n'


# Load wal colors to be used by some scripts
. /home/brendan/.cache/wal/colors.sh

# Print a nice display when the session starts
ufetch
