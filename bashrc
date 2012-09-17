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
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# adds the current branch name in red with info on non-committed changes trailing.
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  change_count=$(git status -s 2> /dev/null | wc -l)
  output=""
  if [[ -n $ref ]]; then
    output="[${ref#refs/heads/}"
  fi
  if [[ $change_count -gt 0 ]]; then
    output="$output $change_count"
  fi
  if [[ -n $output ]]; then
    echo "$output] "
  fi
}

PS1='\[\e[01;31m\]$(git_prompt_info)\[\e[00m\]\[\e[01;32m\]\u\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\]\$ '

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


