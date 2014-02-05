# drive cloning:
	# rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# zsh options
	setopt bash_autolist #bash-like tab completion
  HISTSIZE=50000
	SAVEHIST=50000
  setopt APPEND_HISTORY
  setopt HIST_FIND_NO_DUPS
  setopt HIST_REDUCE_BLANKS
  setopt INC_APPEND_HISTORY
  setopt SHARE_HISTORY
  setopt EXTENDED_HISTORY
	HISTFILE=~/.history.zsh
	bindkey -e

	# Extra completions ==> https://github.com/zsh-users/zsh-completions

	fpath=(/home/jake/.zsh-completions/src $fpath)

	# Command completion
	autoload -U compinit && compinit -C

# Profile options

   if [[ `id -u` == '0' ]]; then
      PROMPT=$'(%d) >> '
   else
      PROMPT=$'(%d) > '
   fi

	export ZLE_REMOVE_SUFFIX_CHARS="" # Stops zsh from eating space after tab completions

	if [ $COLORTERM ]; then
		export TERM="xterm-256color"
	fi

	if [[ $(uname) == "Darwin" ]]; then
		alias ls='ls -G'
		else alias ls='ls --color=auto'
	fi

	export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/nginx/sbin:~/scripts:~/.gem/ruby/2.1.0/bin:~/source/depot_tools

	export EDITOR="vim"
	export PYTHONSTARTUP=~/.python-autocomplete.py
  export BROWSER="google-chrome-beta"

	alias d="pwd"
	alias p="ss -tn"
	alias u="id -u -n"
  alias less="less -Cr"
	alias hist="history"
	alias histt="history -t %m/%d\ -\ %r"
  alias down="cd ~/downloads"
  alias python="python2"
