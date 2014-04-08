# DRIVE CLONING
#  rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# ZSH OPTIONS

# setopt bash_autolist
export ZLE_REMOVE_SUFFIX_CHARS=""
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.history.zsh
setopt APPEND_HISTORY
# setopt CORRECT
setopt AUTO_CD
setopt NOHUP
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
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
# bindkey -e

export CORRECT_IGNORE='_*'
bindkey ';5A' up-line-or-history
bindkey ';5B' down-line-or-history
bindkey ';5C' forward-char
bindkey ';5D' backward-char

# EXTRA COMPLETIONS ==> https://github.com/zsh-users/zsh-completions

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
alias z="source ~/.zshrc"
alias hide="/home/jake/scripts/hide_cursor/hide.sh"
alias :wq="exit" # Vi has ruined me
alias :q="exit"

function zle-line-init zle-keymap-select {
  if [[ `id -u` == '0' ]]; then
    PROMPT="${${KEYMAP/vicmd/<< }/(main|viins)/>> }"
  else
    PROMPT="${${KEYMAP/vicmd/< }/(main|viins)/> }"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init
bindkey -rM vicmd ":" # Annoying as shit
zle -N zle-keymap-select
# Use vi-style keybindings
bindkey -v
# Remove escape timeout in insert mode
bindkey -rpM viins '^['
# Remove escape timeout in normal mode
bindkey -rpM vicmd '^['
# ------------------------------------------------------------------------------
# - insert_mode_(key bindings)                                                 -
# ------------------------------------------------------------------------------
# Have i_backspace work as it does in Vim.
bindkey -M viins "^?" backward-delete-char
# Have i_ctrl-a work as it does in Vim.
bindkey -M viins "^A" beginning-of-line
# Have i_ctrl-p work as c_ctrl-p does in Vim.
bindkey -M viins "^P" up-line-or-history
# Have i_ctrl-e work as it does in Vim.
bindkey -M viins "^E" end-of-line
# Have i_ctrl-n work as c_ctrl-n does in Vim.
bindkey -M viins "^N" down-line-or-history
# Have i_ctrl-h work as it does in Vim.
bindkey -M viins "^H" backward-delete-char
# Have i_ctrl-b work as i_ctrl-p does in Vim.
bindkey -M viins "^B" _history-complete-newer
# Have i_ctrl-f work as i_ctrl-n does in Vim.
bindkey -M viins "^F" _history-complete-older
# Prepend "sudo ".  This does not have a Vim parallel.
bindkey "^S" prepend-sudo
# Prepend "vim ".  This does not have a Vim parallel.
bindkey "^V" prepend-vim
# Have i_ctrl-u work as it does in Vim.
bindkey -M viins "^U" backward-kill-line
# Have i_ctrl-w work as it does in Vim.
bindkey -M viins "^W" backward-kill-word
# Have i_ctrl-x_i_ctrl-l work as it does in Vim.
bindkey -M viins "^X^L" history-beginning-search-backward-then-append
# Display _completion_help for creating completion functions.  This does not
# have a Vim parallel.
bindkey -M viins "^X^H" _complete_help
# attempt to complete line based on history, roughly as i_ctrl-x_ctrl-l does in
# Vim.
bindkey -M viins "^X^L" history-incremental-search-backward
# Cut the contents of the line and paste immediately when the next prompt
# appears.  This does not have a clean Vim parallel.
bindkey -M viins "^Y" push-line
# ------------------------------------------------------------------------------
# - normal_mode_(key_bindings)                                                 -
# ------------------------------------------------------------------------------
# Mimics Vim's "ca" text object functionality.
bindkey -M vicmd "ca" change-around
# Mimics Vim's "ci" text object functionality.
bindkey -M vicmd "ci" change-in
# If not explicitly set, above ca/ci bindings will cause a delay
bindkey -M vicmd "cc" vi-change-whole-line
# Mimic Vim's da text-object functionality.
bindkey -M vicmd "da" delete-around
# Mimic Vim's di text-object functionality.
bindkey -M vicmd "di" delete-in
# If not explicitly set, above da/di bindings will cause a delay
bindkey -M vicmd "dd" kill-whole-line
# Have gg work as it does in Vim.
bindkey -M vicmd "gg" beginning-of-history
# Have G work as it does in Vim.
bindkey -M vicmd "G" end-of-history
# Have ctrl-r work as it does in Vim.
bindkey -M vicmd "^R" redo
# Editing the line in Vim proper.
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^V" edit-command-line
bindkey -M vicmd v edit-command-line
