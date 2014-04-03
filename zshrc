# DRIVE CLONING
#  rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# ZSH OPTIONS

setopt bash_autolist
export ZLE_REMOVE_SUFFIX_CHARS=""
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.history.zsh
setopt APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt COMPLETE_ALIASES
bindkey -e

# EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

fpath=(/home/jake/.zsh-completions/src $fpath)
autoload -U compinit && compinit -C

# PROFILE OPTIONS
# export PROMPT=$'┌───[\e[0;91m%n\e[0m@%M:\e[0;32m%d\e[0m]\n└╼ '

if [[ `id -u` == '0' ]]; then
  PROMPT=$'\>\> '
else
  PROMPT=$'\> '
fi

if [ $COLORTERM ]; then
  export TERM="xterm-256color"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G'
  else alias ls='ls --color=auto'
fi

export PATH=$PATH:~/dotfiles/scripts:~/.config/bspwm/panel:~/.config/bspwm/bar:/opt/firefox

export EDITOR="vim"
export PYTHONSTARTUP=~/.python-autocomplete.py
export BROWSER="chromium"

alias sl="ls"
alias d="pwd"
alias p="netstat -plantu" # netstat apparently deprecated by ss
alias u="id -u -n"
alias less="less -Cr"
alias h="history -t %m/%d\ -\ %r"
alias dl="cd ~/downloads"
alias sc="cd ~/source"
alias gp="git pull"
alias gc="git clone"
alias ..="cd .."
alias l="ls"
alias c="cd"
alias v="vim"
alias emacs="emacs -nw"
