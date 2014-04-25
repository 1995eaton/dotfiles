# DRIVE CLONING
#  rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# ZSH OPTIONS

export ZLE_REMOVE_SUFFIX_CHARS=""
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.history.zsh
setopt APPEND_HISTORY
setopt AUTO_CD
setopt NOHUP
setopt PROMPT_SUBST
setopt NOCHECKJOBS
setopt GLOB_COMPLETE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INTERACTIVE_COMMENTS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt NO_FLOW_CONTROL
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt COMPLETE_ALIASES
KEYTIMEOUT=1
export CORRECT_IGNORE='_*'

# EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select

fpath=(/home/jake/.zsh-completions/src $fpath)
autoload -U compinit && compinit -C

# PROFILE OPTIONS

if [ $COLORTERM ]; then
  export TERM="xterm-256color"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G'
  else alias ls='ls --color=auto'
fi


export PATH=$PATH:~/dotfiles/scripts:~/.config/bspwm/panel:~/.config/bspwm/bar:/opt/firefox:/home/jake/.gem/ruby/2.1.0/bin:/home/jake/source/depot_tools/src/out/Release
export GOOGLE_API_KEY="AIzaSyAIOUE9BrHCDxhMbYkArx357qgW258VYhI"
export GOOGLE_DEFAULT_CLIENT_ID="12183383802-ed4qc36t32aqvrkjjto17voq6ks19voj.apps.googleusercontent.com"
export GOOGLE_DEFAULT_CLIENT_SECRET="VWJmeusSKze56W_oWpMA8u6b"
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

export EDITOR="vim"
export PYTHONSTARTUP=~/.python-autocomplete.py
export BROWSER="chromium"

alias sl="ls"
alias d="pwd"
alias p="netstat -plantu" # netstat apparently deprecated by ss
alias killvim='$(kill -9 `ps -eo pid,comm | grep vim | egrep -o "[0-9]+" | tr "\n" " "`)'
alias u="id -u -n"
alias less="less -Cr"
alias ed="ed -p '-> '"
alias h="history -t %m/%d\ -\ %r"
alias dl="cd ~/downloads"
alias sc="cd ~/source"
alias su="sudo su"
alias gp="git pull"
alias gc="git clone"
alias l="ls"
alias emacs="emacs -nw"
alias c="cd"
alias v="vim"
alias z="source ~/.zshrc"
alias hide="/home/jake/scripts/hide_cursor/hide.sh"
alias :wq="exit" # Vi has ruined me
alias :q="exit"

NORMAL_PS1_COLORS=('233' '250')
ROOT_PS1_COLORS=('233' '118')
VIM_PS1_COLORS=('254' '161')


function zle-line-init zle-keymap-select {
  PROMPT=$'%F{161}${${KEYMAP/vicmd/%(!.<.%f<)}/main/%(!.>.%f>)}%f '
  zle reset-prompt
}

# function zle-line-init zle-keymap-select {
#   if [[ ${KEYMAP/vicmd} == "main" ]]; then
#     if [[ $UID == '0' ]]; then
#       FG=$ROOT_PS1_COLORS[1]
#       BG=$ROOT_PS1_COLORS[2]
#     else
#       FG=$NORMAL_PS1_COLORS[1]
#       BG=$NORMAL_PS1_COLORS[2]
#     fi
#   else
#     FG=$VIM_PS1_COLORS[1]
#     BG=$VIM_PS1_COLORS[2]
#   fi
#   # PROMPT=$'%F{$FG}%K{$BG%}%m%K{238}%F{$BG}%F{253} %~%k%F{238}%f'
#   # PROMPT=$'%F{$FG}%K{$BG%}%m%K{238}%F{$BG}%F{253} %~ %k%F{238}%f'
#   PROMPT=$'%F{$FG}%K{$BG%} %m %K{238}%F{$BG}%F{253} %~ %k%F{238}%f'
#   zle reset-prompt
# }

zsh-exit() {
  exit
}
zle -N zsh-exit
bindkey -r '^D'
bindkey '^D' zsh-exit
bindkey -rM vicmd ":" # Annoying as shit
zle -N zle-keymap-select
zle -N zle-line-init
bindkey -v
bindkey -rpM viins '^['
bindkey -rpM vicmd '^['
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^H" backward-delete-char
bindkey -rpM viins '^[[D'
bindkey -rpM vicmd '^[[D'
bindkey -M viins "^B" _history-complete-newer
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^X^L" history-beginning-search-backward-then-append
bindkey -M viins "^X^H" _complete_help
bindkey -M viins "^X^L" history-incremental-search-backward
bindkey -M viins "^Y" push-line
bindkey -M vicmd "ca" change-around
bindkey -M vicmd "ci" change-in
bindkey -M vicmd "cc" vi-change-whole-line
bindkey -M vicmd "da" delete-around
bindkey -M vicmd "di" delete-in
bindkey -M vicmd "dd" kill-whole-line
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "^R" redo
autoload edit-command-line
zle -N edit-command-line
bindkey  "^V" edit-command-line
bindkey -M vicmd v edit-command-line
