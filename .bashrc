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

# Various global settings
export EDITOR='nvim'
export BROWSER='firefox'
export TERMINAL='st'

# Path extensions
#export PATH=~/.nimble/bin:$PATH
#export PATH=~/tools/wabt/out/gcc/Release:$PATH
export PATH="/home/brendan/.yarn/bin:$PATH"
#export PATH=~/.pub-cache/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts/utils:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
source $HOME/.shortcuts

# Program aliases
alias ls='ls --color=auto'
alias l="ls -hN -al --group-directories-first"
alias v="$EDITOR"
alias r="ranger"
alias f="$HOME/.config/vifm/scripts/vifmrun"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME'

# Utility aliases
alias cl="clear; ls -lh"
alias md="mkdir -p"
alias SS="sudo sv"
alias xi="sudo xbps-install"
alias xq="xbps-query -R -s"
alias ccat="highlight --out-format=ansi"
alias oof="sudo"

# Tmux aliases
alias ta="tmux a -t"
alias tn="tmux new-session -s"
alias tk="tmux kill-session -t"
alias tl="tmux list-sessions"

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
export PS1="\n\[$(tput bold)\][\[$(tput sgr0)\]\[\033[34m\]\u\[$(tput sgr0)\]\[\033[37m\]@\[$(tput sgr0)\]\[\033[34m\]\h\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[31m\]\$?\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[32m\]\W\[$(tput sgr0)\]\[\033[37m\]]\[$(tput sgr0)\]\\n\\$\[$(tput sgr0)\] "
