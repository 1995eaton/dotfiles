# DRIVE CLONING
#  rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /mnt

stty -ixon # disables flow control (C-s and C-q)

HISTFILE=~/.history.zsh
HISTSIZE=500000
SAVEHIST=500000
KEYTIMEOUT=1

setopt APPEND_HISTORY
setopt NULL_GLOB
setopt AUTO_CD
setopt HIST_IGNORE_SPACE
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS
setopt NOCHECKJOBS
setopt NOHUP
setopt NO_FLOW_CONTROL
setopt PROMPT_SUBST

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search

autoload -U select-word-style
select-word-style bash

# EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

fpath=(/home/jake/.zsh-completions/src $fpath)
autoload -Uz compinit && compinit -C

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache.zsh
zstyle ':completion:*' menu select

# LS COLORS ==> https://github.com/twam/.dotfiles/blob/master/ls_colors/ls_colors.zsh
autoload colors; colors;
LS_COLORS='di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32';
LSCOLORS='ExGxFxDxCxDxDxhbhdacEc';
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

[ $COLORTERM ] && export TERM='screen-256color'

export ZLE_REMOVE_SUFFIX_CHARS=''
export CORRECT_IGNORE='_*'
export LISTMAX=0
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
export EDITOR='vim'
export PYTHONSTARTUP=~/.python/startup.py
export BROWSER='chromium --test-type'
export GOPATH=~/.go
export GCC_COLORS=always
export NLTK_DATA=/home/jake/.nltk_data
export QUOTING_STYLE=literal
export ANDROID_HOME=/opt/android-sdk

function {
  local PATH_ARRAY; PATH_ARRAY=(
    ~/dotfiles/scripts
    ~/.config/bspwm/panel
    /home/jake/.gem/ruby/*/bin
    /home/jake/.npm/bin
    $GOPATH/bin
    /home/jake/source/code-templates/bin
  )
  local IFS=:
  shift 0
  export PATH="`echo "$PATH_ARRAY:$PATH"`"
}

alias :q='exit'
alias :wq='exit'
alias d='pwd'
alias dl='cd ~/downloads'
alias emacs='emacs -nw'
alias gc='git clone'
alias gu='git ls-files --others --exclude-standard'
alias gd='git diff'
alias gdh='git diff HEAD~1'
alias gds='git diff --stat'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias chrome=' chrome --test-type --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version=`grep -i version /usr/lib/PepperFlash/manifest.json | grep -oE "[0-9.]+"`'
alias killvim='$(kill -9 `ps -eo pid,comm | grep vim | egrep -o "[0-9]+" | tr "\n" " "`)'
alias less='less -Cr'
alias su='sudo su'
alias z='source ~/.zshrc'
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias view='vim -R'
alias node='node --es_staging --harmony'
alias pacman='pacman --color=always'
alias yo='yaourt -Syua'
alias ls='ls --color=always'
alias j='ps axk%cpu -o %cpu,%mem,pid,cmd'

numix_colors() {
  find /usr/share/themes/Numix -type f -print0 | sudo xargs -0 sed -i 's/#F0544C/#f92672/gi'
  find /usr/share/themes/Numix -type f -print0 | sudo xargs -0 sed -i 's/#444444/#1c1c1c/gi'
}
arc_colors() {
  find /usr/share/themes/Arc-Darker -type f -print0 | sudo xargs -0 sed -i 's/#2F343F/#1c1c1c/gi'
}

alias c='cd'
alias dc='cd'
alias l='ls'
alias s='ls'
alias sl='ls'

function cpui() {
  sudo cpupower -i
}
function cpull() {
  sudo cpupower -g powersave --min=0.8 --max=0.8
  sudo cpupower -i
}
function cpul() {
  sudo cpupower -g powersave --min=0.8 --max=1.6
  sudo cpupower -i
}
function cpun() {
  sudo cpupower -g powersave --min=0.8 --max=2.4
  sudo cpupower -i
}
function cpuh() {
  sudo cpupower -t 1
  sudo cpupower -p100 --min=3.4 --max=3.4
  sudo cpupower -g performance
  sudo cpupower -i
}

function zle-line-init zle-keymap-select {
  if [[ ${KEYMAP/vicmd} == "main" ]]; then
    PROMPT=$'%F{161}%(!.$.%f$)%f '
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

zsh-exit() { exit }
zle -N zsh-exit
bindkey -r '^D'
bindkey '^D' zsh-exit

bindkey -v
autoload edit-command-line
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd 'G' end-of-history
bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^B' backward-char
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^F' forward-char
bindkey -M vicmd '^J' down-line-or-beginning-search
bindkey -M vicmd '^K' up-line-or-beginning-search
bindkey -M vicmd '^R' redo
bindkey -M vicmd '^V' edit-command-line
bindkey -M vicmd 'dd' kill-whole-line
bindkey -M vicmd 'gg' beginning-of-history
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -rM vicmd ':'
bindkey -rpM vicmd '^['
bindkey -rpM vicmd '^[[D'
bindkey -rpM viins '^['
bindkey -rpM viins '^[[D'

bindkey '^B' backward-char
bindkey '^F' forward-char
bindkey '^[[Z' reverse-menu-complete
bindkey '^K' up-line-or-beginning-search
bindkey '^J' down-line-or-beginning-search

### {{{ vim-run
VIM_FIFO_FILE=/tmp/vim-fifo

ctrl_c_trap() {
  rm "$VIM_FIFO_FILE"
  trap - INT
}

vim_fifo() {
  [[ -e $VIM_FIFO_FILE ]] && rm "$VIM_FIFO_FILE"
  mkfifo "$VIM_FIFO_FILE"
  trap ctrl_c_trap INT
  tail -f "$VIM_FIFO_FILE"
}
### }}}

source /home/jake/.vim/bundle/vim-run/plugin/shell.sh

# VIM MODE [CD]I COMMANDS ==> https://github.com/hchbaw/opp.zsh
source /home/jake/.zsh-opp/opp.zsh
source /home/jake/scripts/cmp.zsh
