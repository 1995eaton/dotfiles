# DRIVE CLONING
#  rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

HISTFILE=~/.history.zsh
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=1

setopt APPEND_HISTORY
setopt AUTO_CD
setopt COMPLETE_ALIASES
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt GLOB_COMPLETE
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
autoload -U compinit && compinit -C

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

[ $COLORTERM ] && export TERM='xterm-256color'

if ls --color -d . &>/dev/null 2>&1; then
  export LS_COLORS=$LS_COLORS
  alias ls='ls --color=always'
else
  export LSCOLORS=$LSCOLORS
  alias ls='ls -G'
fi

export PATH=$PATH:~/dotfiles/scripts:~/.config/bspwm/panel:~/.config/bspwm/bar:/home/jake/.gem/ruby/2.1.0/bin:/home/jake/source/depot_tools/src/out/Release:/home/jake/.npm/bin:$GOPATH/bin:/home/jake/source/templates/bin
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
export EDITOR='vim'
export PYTHONSTARTUP=~/.python-autocomplete.py
export BROWSER='google-chrome-unstable'
export GOPATH=~/.go
export GCC_COLORS=always

function tcp() {
  traceur --array-comprehension true --spread true --classes true --generators true \
    --for-of true --rest-parameters true --destructuring true --arrow-functions true \
    --script $1 --out $2;
}

alias 6to5='6to5 -b generators --experimental'
alias 6to5-node='6to5-node --experimental'
alias mac="echo -e \$(hexdump -ve '/1 \"%02x:\"' /dev/urandom | fold -w18 | head -c17)"
alias ns='ss -plantu | sed "s/\S\+:((\|))$//g" | tr "," "	" | column -t -s"	"'
alias -g H='|& head -n20'
alias -g L='|& less'
alias -g SP='|& tr \"\n\" \",\" |& sed "s/,$/\n/"'
alias -g T='|& tail -n20'
alias -g V='|& view -'
alias .='xsel -b'
alias :q='exit'
alias :wq='exit' # Vi has ruined me
alias c='cd'
alias cwdtopath='export PATH=$(pwd):$PATH'
alias d='pwd'
alias dl='cd ~/downloads'
alias ed='ed -p "-> "'
alias emacs='emacs -nw'
alias gc='git clone'
alias gcm='git commit -a -m'
alias gco='git commit'
alias gd='git diff'
alias gdh='git diff HEAD~1'
alias gds='git diff --stat'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias chrome=' chrome --test-type --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version=`grep -i version /usr/lib/PepperFlash/manifest.json | grep -oE "[0-9.]+"`'
alias gp='git pull'
alias gpu='git push'
alias h='history -t %m/%d\ -\ %r'
alias hide='/home/jake/scripts/hide_cursor/hide.sh'
alias irb='irb --prompt simple'
alias killvim='$(kill -9 `ps -eo pid,comm | grep vim | egrep -o "[0-9]+" | tr "\n" " "`)'
alias l='ls'
alias less='less -Cr'
alias p='netstat -plantu'
alias s='ls'
alias sc='cd ~/source'
alias sl='ls'
alias su='sudo su'
alias js='node'
alias u='id -u -n'
alias v='vim'
alias quiet='sudo cpupower -g powersave --min=0.8 --max=1.8 -i'
alias help='echo -n ""'
alias z='source ~/.zshrc'
alias cpui='sudo cpupower -i'
alias cpuh='sudo cpupower --high -i'
alias gcc='gcc -std=c11 -Wall -Wextra -pedantic'
alias g++='g++ -std=c++14 -Wall -Wextra -pedantic'
alias html='template html'
alias find='noglob find'

function cpull() {
  sudo cpupower -g powersave --min=0.8 --max=0.8
  sudo cpupower -i
}
function cpul() {
  sudo cpupower -g powersave --min=0.8 --max=1.6
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
#source /home/jake/.vimfifo
source /home/jake/.zsh-npmcompletions
source /home/jake/scripts/cmp.zsh
