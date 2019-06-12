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

export EDITOR='nvim'
export BROWSER='firefox'
export TERMINAL='st'

#export PATH=~/.nimble/bin:$PATH
#export PATH=~/tools/wabt/out/gcc/Release:$PATH
export PATH="/home/brendan/.yarn/bin:$PATH"
#export PATH=~/.pub-cache/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts/utils:$PATH"
source $HOME/.shortcuts

alias ls='ls --color=auto'
alias l="ls -hN -al --group-directories-first"
alias cl="clear; ls -lh"
alias md="mkdir -p"
alias SS="sudo sv"
alias xi="sudo xbps-install"
alias xq="xbps-query -R -s"
alias ccat="highlight --out-format=ansi"
alias oof="sudo"
alias v="$EDITOR"
alias r="ranger"
alias f="$HOME/.config/vifm/scripts/vifmrun"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME'

m() {
	man -k "^$@$" >/dev/null && man -Tpdf "$@" | zathura - ;
}

vf() {
	fzf | xargs -r $EDITOR
}

zf() {
	cat <(find "$HOME/Dropbox/docs" -name '*.pdf') <(find "$HOME/Dropbox/docs" -name '*.ps') | fzf | xargs -r zathura ;
}

export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export QUTEWAL_DYNAMIC_LOADING=True

. /home/brendan/.cache/wal/colors.sh

# neofetch
ufetch

# function _update_ps1() {
# 	PS1=$(/home/brendan/.local/bin/powerline-shell $?)
# }
# 
# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
# 	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi


# Old PS1s
# PS1='[\u@\h \W]\$ '
export PS1="\n\[$(tput bold)\][\[$(tput sgr0)\]\[\033[34m\]\u\[$(tput sgr0)\]\[\033[37m\]@\[$(tput sgr0)\]\[\033[34m\]\h\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[31m\]\$?\[$(tput sgr0)\]\[\033[37m\] \[$(tput sgr0)\]\[\033[32m\]\W\[$(tput sgr0)\]\[\033[37m\]]\[$(tput sgr0)\]\\n\\$\[$(tput sgr0)\] "
