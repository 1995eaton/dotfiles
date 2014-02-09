#DRIVE CLONING

#rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

#ZSH OPTIONS

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

#EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

fpath=(/home/jake/.zsh-completions/src $fpath)
autoload -U compinit && compinit -C

#PROFILE OPTIONS

if [[ `id -u` == '0' ]]; then
  PROMPT=$'(%d) >> '
else
  PROMPT=$'(%d) > '
fi

if [ $COLORTERM ]; then
  export TERM="xterm-256color"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G'
  else alias ls='ls --color=auto'
fi

export PATH=$PATH:~/scripts:~/.gem/ruby/2.1.0/bin

export EDITOR="vim"
export PYTHONSTARTUP=~/.python-autocomplete.py
export BROWSER="google-chrome-beta"

alias d="pwd"
alias p="ss -tn"
alias u="id -u -n"
alias less="less -Cr"
alias h="history -t %m/%d\ -\ %r"
alias dl="cd ~/downloads"
