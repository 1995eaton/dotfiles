# drive cloning:
	# rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# zsh options
	setopt bash_autolist #bash-like tab completion
   HISTSIZE=5000
	SAVEHIST=1000
	HISTFILE=~/.history.zsh
	bindkey -e

	# Extra completions ==> https://github.com/zsh-users/zsh-completions

	fpath=(/home/jake/.zsh-completions/src $fpath)

	# Command completion
	autoload -U compinit && compinit -C

# Profile options

   if [[ `id -u` == '0' ]]; then
      PROMPT=$'>> '
   else
      PROMPT=$'> '
   fi

	export ZLE_REMOVE_SUFFIX_CHARS="" # Stops zsh from eating space after tab completions

	if [ $COLORTERM ]; then
		export TERM="xterm-256color"
	fi

	if [[ $(uname) == "Darwin" ]]; then
		alias ls='ls -G'
		else alias ls='ls --color=auto'
	fi

	export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/nginx/sbin:~/scripts

	export EDITOR="vim"
	export PYTHONSTARTUP=~/.python-autocomplete.py

	alias d="pwd"
	alias p="ss -tn"
	alias u="id -u -n"
	alias less="less -Cr"
	alias hist="history"
	alias histt="history -t %m/%d\ -\ %r"
   alias down="cd ~/downloads"
