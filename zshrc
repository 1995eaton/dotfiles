# DRIVE CLONING
#  rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /mnt

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
export ZLE_REMOVE_SUFFIX_CHARS=''
export CORRECT_IGNORE='_*'

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

function ls() {
/usr/bin/ls --color=always $*
}
# if ls --color -d . &>/dev/null 2>&1; then
  # export LS_COLORS=$LS_COLORS
#   alias -gm ls='ls --color=always'
# else
#   export LSCOLORS=$LSCOLORS
#   alias ls='ls -G'
# fi

export LISTMAX=0
# export PATH=$PATH:~/dotfiles/scripts:~/.config/bspwm/panel:/home/jake/.gem/ruby/2.2.0/bin:/home/jake/.npm/bin:$GOPATH/bin:/home/jake/source/templates/bin

export PATH=$PATH
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
export EDITOR='vim'
export PYTHONSTARTUP=~/.python/startup.py
export BROWSER='chromium --test-type'
export GOPATH=~/.go
export GCC_COLORS=always
export NLTK_DATA=/home/jake/.nltk_data

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

vpn() {
  case $1 in
    0) sudo systemctl stop openvpn@pia  ;;
    1) sudo systemctl start openvpn@pia ;;
    *) [[ `systemctl status openvpn@pia` =~ inactive ]] &&
         echo 'inactive' || echo 'active'
  esac
}

function pacman() {
  if [[ $(id -u) -ne 0 && $1 =~ ^-(S[ycu]*|R.*)$ ]]; then
    sudo /usr/bin/pacman $*
  else
    /usr/bin/pacman $*
  fi
}

alias mac="echo -e \$(hexdump -ve '/1 \"%02x:\"' /dev/urandom | fold -w18 | head -c17)"
alias ns='ss -plantu | sed "s/\S\+:((\|))$//g" | tr "," "	" | column -t -s"	"'
alias -g H='|& head -n20'
alias -g L='|& less'
alias -g SP='|& tr "\n" "," |& sed "s/,$/\n/"'
alias -g T='|& tail -n20'
alias -g V='|& view -'
alias -g @='|xsel -b'
alias :q='exit'
alias :wq='exit'
alias cwdtopath='export PATH=$(pwd):$PATH'
alias d='pwd'
alias dl='cd ~/downloads'
alias ed='ed -p "-> "'
alias emacs='emacs -nw'
alias gc='git clone'
alias gu='git ls-files --others --exclude-standard'
alias gcm='git commit -a -m'
alias gco='git commit'
alias gd='git diff'
alias gdh='git diff HEAD~1'
alias gds='git diff --stat'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias chrome=' chrome --test-type --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version=`grep -i version /usr/lib/PepperFlash/manifest.json | grep -oE "[0-9.]+"`'
alias gp='git pull'
alias h='history -t %m/%d\ -\ %r'
alias hide='/home/jake/scripts/hide_cursor/hide.sh'
alias irb='irb --prompt simple'
alias killvim='$(kill -9 `ps -eo pid,comm | grep vim | egrep -o "[0-9]+" | tr "\n" " "`)'
alias less='less -Cr'
alias p='netstat -plantu'
alias sc='cd ~/source'
alias su='sudo su'
alias u='id -u -n'
alias v='vim'
alias quiet='sudo cpupower -g powersave --min=0.8 --max=1.8 -i'
alias help='echo -n ""'
alias z='source ~/.zshrc'
alias cpui='sudo cpupower -i'
alias html='template html'
# alias find='noglob find'
alias csc='cd /home/jake/source/CSC/CSC-151'
alias size='du -h --apparent-size'
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias view='vim -R'
alias python-sympy='PYTHONSTARTUP=~/.python/startup-sympy.py python'
alias node='node --use_strict'
alias pacman='pacman --color=always'
alias yo='yaourt -Syua'

numix_colors() {
  find /usr/share/themes/Numix -type f -print0 | sudo xargs -0 sed -i 's/#ff184d/#f92672/g'
  find /usr/share/themes/Numix -type f -print0 | sudo xargs -0 sed -i 's/#2d2d2d/#1c1c1c/g'
}

alias c='cd'
alias dc='cd'
alias cc='cd'

alias l='ls'
alias s='ls'
alias ss='ls'
alias ll='ls'
alias lsl='ls'
alias lss='ls'
alias sll='ls'
alias ssl='ls'
alias slll='ls'
alias sl='ls'

# function accept-line() {
#   read -A tokens <<< ${BUFFER:gs/\\/\\\\}
#   if [[ "${tokens[1]}" == % ]]; then
#     BUFFER='noglob '${tokens[2,#tokens]}
#     zle .accept-line
#   fi
#   # fi
#   # noglob eval $*
# }
# zle -N _alias ng
# zle -N accept-line
alias %='noglob'

alias cpu='ps axk%cpu -o %cpu,%mem,pid,cmd'
alias j='ps axk%cpu -o %cpu,%mem,pid,cmd'

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

# VIM MODE [CD]I COMMANDS ==> https://github.com/hchbaw/opp.zsh
source /home/jake/.zsh-opp/opp.zsh

stty -ixon # disables flow control (C-s and C-q)
source /home/jake/scripts/cmp.zsh
source /home/jake/.vim/bundle/vim-fifo/rcplugin
