# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval $(/usr/bin/lesspipe)
# this gives the following error on gentoo but not Ubuntu
## /bin/bash: eval: line 0: syntax error near unexpected token `newline'
## /bin/bash: eval: line 0: `Usage: lesspipe <file>'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|screen) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# from BLFS
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
BLUE="\[\e[1;34m\]"
GREY="\[\e[1;30m\]"
#if [[ $EUID == 0 ]] ; then
#  PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
#else
#  PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
#fi
#export PS1

# now set PS1 to grey timestamp, normal terminal# and hostname,
#      green username and blue path
if [ "$color_prompt" = yes ]; then {
    # WINDOW is set by screen, can use bash's \l if that's not set.
        # WINDOW 1 special prompt
    if [[ $WINDOW -eq 1 && $TERM == "screen-bce" ]]; then {
        PS1="${debian_chroot:+($debian_chroot)}$GREY\D{%Y%m%d} T \t $NORMAL$WINDOW $GREEN\u$NORMAL@\h:$BLUE\w$NORMAL\$ " ; }
    else {
        PS1="${debian_chroot:+($debian_chroot)}$GREY\t $NORMAL$WINDOW $GREEN\u$NORMAL@\h:$BLUE\w$NORMAL\$ " ; }
    fi }
else {
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ; }
fi

unset color_prompt force_color_prompt
unset NORMAL RED GREEN BLUE GREY

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

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

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export IRCNICK
# fung1

# for ruby gems 20130711
export PATH=/var/lib/gems/1.8/bin:$PATH

PATH=$PATH:$HOME/bin:$HOME/.rvm/bin # Add bin and RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# for Debian
export DEBEMAIL="grantbow@svpal.org"
export DEBFULLNAME="Grant Bowman"
export PBUILDFOLDER=/var/cache/pbuilder

