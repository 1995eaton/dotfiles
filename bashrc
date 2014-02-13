# drive cloning:
	# rsync -aAXv /* /path/to/backup/folder --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}

# Profile options
	if [[ $(id -u) == "0" ]]; then
		PROMPT=$'\e\[38;5;214m>>>\e\[0m\ '
	else
		PROMPT=$'>>> '
	fi

	if [ $COLORTERM ]; then
		export TERM="xterm-256color"
	fi

	if [[ $(uname) == "Darwin" ]]; then
		alias ls='ls -G'
		else alias ls='ls --color=auto'
	fi

	export PATH=/usr/local/bin:/usr/local/Cellar:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/nginx/sbin:~/.scripts

	export EDITOR="vim"
	export PYTHONSTARTUP="~/python-autocomplete.py"

	alias d="pwd"
	alias p="ss -tn"
	alias su="sudo -s"
	alias u="id -u -n"
	alias t="tree -C -L 3"
	alias less="less -Cr"
