# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

## Command Prompt setup
# Color definition
COLOR_HOST="\e[38;5;2m"
COLOR_PATH="\e[38;5;3m"
#COLOR_GIT="\e[38;5;11m"
COLOR_GIT="\e[38;5;3m"
COLOR_CHANGE="\e[38;5;9m"
COLOR_RESET="\e[0m"

# Format the git information
function parse_git_branch {
	# Check if we are in a git repo
	if [ -d .git ] || git rev-parse --is-inside-work-tree &>/dev/null; then
		local git_status="$(git status --porcelain=v1 2>/dev/null)"

		function _count_git_pattern() {
			echo "$(grep "^$1" <<<$git_status | wc -l)"
		}

		local branch="$(git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")"
		local remote_branch="origin/${branch}"
		local staged_modified=$(_count_git_pattern "M ")
		local unstaged_modified=$(_count_git_pattern " M")
		local both_modified=$(_count_git_pattern "MM")
		local staged_deleted=$(_count_git_pattern "D ")
		local unstaged_deleted=$(_count_git_pattern " D")
		local staged_renamed=$(_count_git_pattern "R ")
		local unstaged_renamed=$(_count_git_pattern " R")
		local added_files=$(_count_git_pattern "A ")
		local untracked_files=$(_count_git_pattern "??")
		local ahead_commits=$(git rev-list --count ${remote_branch}..${branch} 2>/dev/null)
		local behind_commits=$(git rev-list --count ${branch}..${remote_branch} 2>/dev/null)

		local git_info="[$branch"

		if [[ "$ahead_commits" -gt 0 || "$behind_commits" -gt 0 ]]; then
			git_info="${git_info} | C: \x01$COLOR_HOST\x02${ahead_commits}\x01$COLOR_GIT\x02/\x01$COLOR_CHANGE\x02${behind_commits}\x01$COLOR_GIT\x02"
		fi

		if [[ $staged_renamed -gt 0 || $unstaged_renamed -gt 0 ]]; then
			git_info="${git_info} | R: \x01$COLOR_HOST\x02${staged_renamed}\x01$COLOR_GIT\x02/\x01$COLOR_CHANGE\x02${unstaged_renamed}\x01$COLOR_GIT\x02"
		fi

		if [[ $staged_deleted -gt 0 || $unstaged_deleted -gt 0 ]]; then
			git_info="${git_info} | D: \x01$COLOR_HOST\x02${staged_deleted}\x01$COLOR_GIT\x02/\x01$COLOR_CHANGE\x02${unstaged_deleted}\x01$COLOR_GIT\x02"
		fi

		if [[ $staged_modified -gt 0 || $unstaged_modified -gt 0 || $both_modified -gt 0 ]]; then
			git_info="${git_info} | M: \x01$COLOR_HOST\x02$((staged_modified + both_modified))\x01$COLOR_GIT\x02/\x01$COLOR_CHANGE\x02$((unstaged_modified + both_modified))\x01$COLOR_GIT\x02"
		fi

		if [[ $untracked_files -gt 0 || $added_files -gt 0 ]]; then
			git_info="${git_info} | U: \x01$COLOR_HOST\x02${added_files}\x01$COLOR_GIT\x02/\x01$COLOR_CHANGE\x02${untracked_files}\x01$COLOR_GIT\x02"
		fi

		git_info="${git_info}]"

		echo -e " $git_info"
	else
		echo ""
	fi
}

# Command prompt color and look
PS1="${debian_chroot:+($debian_chroot)}\001$COLOR_HOST\002\u@\h\001$COLOR_RESET\002:\001$COLOR_PATH\002./\W\$(parse_git_branch)\001$COLOR_RESET\002\n\001$COLOR_PATH\002[\D{%b %d | %H:%M:%S}]\001$COLOR_RESET\002\$ "
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

bind 'set completion-ignore-case on'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export HOME_WIN='/mnt/c/users/vrn1lud'

alias nvim='~/neovim/bin/nvim'
alias pip='/usr/bin/pip3.11'
alias fd='fdfind'

# Python
alias python='/usr/bin/python3.11'
alias python3='/usr/bin/python3.11'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias for docker-compose
alias docker-compose='docker compose'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Tmux
alias tmux='TERM=xterm-256color tmux'

# Zoxide
export PATH=$PATH:~/.local/bin
eval "$(zoxide init --cmd cd bash)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

set -a
source /etc/environment
set +a

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export http_proxy="http://localhost:3128"
export HTTP_PROXY="http://localhost:3128"
export https_proxy="http://localhost:3128"
export HTTPS_PROXY="http://localhost:3128"
export ftp_proxy="http://localhost:3128"
export FTP_PROXY="http://localhost:3128"
export all_proxy="http://localhost:3128"
export ALL_PROXY="http://localhost:3128"