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

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search

# EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

fpath=(/home/jake/.zsh-completions/src $fpath)
autoload -U compinit && compinit -C

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache.zsh
zstyle ':completion:*' menu select

# LS COLORS ==> https://github.com/twam/.dotfiles/blob/master/ls_colors/ls_colors.zsh
autoload colors; colors;
LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="ExGxFxDxCxDxDxhbhdacEc";
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# PROFILE OPTIONS

if [ $COLORTERM ]; then
  export TERM="xterm-256color"
fi

if ls --color -d . &>/dev/null 2>&1; then
  export LS_COLORS=$LS_COLORS
  alias ls='ls --color=tty'
else
  export LSCOLORS=$LSCOLORS
  alias ls='ls -G'
fi


export PATH=$PATH:~/dotfiles/scripts:~/.config/bspwm/panel:~/.config/bspwm/bar:/home/jake/.gem/ruby/2.1.0/bin:/home/jake/source/depot_tools/src/out/Release
export GOOGLE_API_KEY="AIzaSyAIOUE9BrHCDxhMbYkArx357qgW258VYhI"
export GOOGLE_DEFAULT_CLIENT_ID="12183383802-ed4qc36t32aqvrkjjto17voq6ks19voj.apps.googleusercontent.com"
export GOOGLE_DEFAULT_CLIENT_SECRET="VWJmeusSKze56W_oWpMA8u6b"
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

export EDITOR="vim"
export PYTHONSTARTUP=~/.python-autocomplete.py
export BROWSER="google-chrome-unstable"

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
alias cvim="cd ~/source/chromium-vim"
alias gc="git clone"
alias gd="git diff"
alias gdh="git diff HEAD~1"
alias gds="git diff --stat"
alias cwdtopath="export PATH=$(pwd):$PATH"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gcm="git commit -a -m"
alias gco="git commit"
alias gpu="git push"
alias l="ls"
alias emacs="emacs -nw"
alias c="cd"
alias v="vim"
alias z="source ~/.zshrc"
alias hide="/home/jake/scripts/hide_cursor/hide.sh"
alias :wq="exit" # Vi has ruined me
alias :q="exit"
alias .="xsel -b"

alias -g L="|& less"
alias -g SP="|& tr \"\n\" \",\" |& sed 's/,$/\n/'"
alias -g H="|& head -n20"
alias -g T="|& tail -n20"
alias -g V="|& view -"
alias -g C="|& column -t -s"

# NORMAL_PS1_COLORS=('233' '250')
# ROOT_PS1_COLORS=('233' '118')
# VIM_PS1_COLORS=('254' '161')

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

# ZLE INITS

function zle-line-init zle-keymap-select {
  if [[ ${KEYMAP/vicmd} == "main" ]]; then
    PROMPT=$'%F{161}%(!.>.%f>)%f '
  else
    PROMPT=$'%F{161}%(!.<.%f<)%f '
  fi
  zle reset-prompt
}
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N zle-keymap-select
zle -N zle-line-init

zle -N edit-command-line
zle -N zsh-exit
bindkey -r "^D"
bindkey "^D" zsh-exit

bindkey -rM vicmd ":"
bindkey -v
bindkey -rpM viins "^["
bindkey -rpM vicmd "^["
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^H" backward-delete-char
bindkey -rpM viins "^[[D"
bindkey -rpM vicmd "^[[D"
bindkey -M viins "^U" backward-kill-line
bindkey "^R" history-incremental-search-backward
bindkey -M viins "^W" backward-kill-word
bindkey -M vicmd "dd" kill-whole-line
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "^R" redo
autoload edit-command-line
bindkey -M vicmd "^V" edit-command-line
bindkey -M vicmd "^K" up-line-or-beginning-search
bindkey -M vicmd "^J" down-line-or-beginning-search

bindkey '^[[Z' reverse-menu-complete
bindkey "^K" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search
# VIM MODE [CD]I COMMANDS ==> https://github.com/hchbaw/opp.zsh
source /home/jake/.zsh-opp/opp.zsh
source /home/jake/.visual.zsh
# STARTUP COMMANDS
stty -ixon # disables flow control (C-s and C-q)
bindkey -s '^G' 'echo -e -n \"\\033(0\"'
alias sane='echo -n ""'
source /home/jake/.vimfifo
