# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd
set -k

export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi
# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
# bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

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

PASS='✔'
FAIL='✘'
SEGV='☢'
SUPER='⚡'
CLOUD="☁️"
CLEAR=$'%{\033[0;0m%}'
RED=$'%{\033[0;0m%}%{\033[1;41m%}'
GREEN=$'%{\033[0;0m%}%{\033[0;42m%}'
WHITE=$'%{\033[0;0m%}'
LIGHT_BLUE=$'%{\033[0;0m%}%{\033[0;34m%}'
YELLOW=$'%{\033[0;0m%}%{\033[0;33m%}'
LIGHT_CYAN=$'%{\033[0;0m%}%{\033[0;36m%}'
PURPLE=$'%{\033[0;0m%}%{\033[0;35m%}'

return_prompt() {
  RC=$?
  RETURN_OUTPUT=''
  if [ $RC -eq 0 ]; then
    echo "${GREEN}${PASS}${WHITE}"
  elif [ $RC -eq 139 ]; then
    echo "${RED}${SEGV}${WHITE}"
  else
    echo "${RED}${FAIL}${WHITE}"
  fi
}

# weather_prompt() {
#   cat ~/.cli-weather-forecast
# }
#
cloud_info() {
  if ! [ -z "$HEROKU_CLOUD" ]; then
    echo -n " ${WHITE}$CLOUD  $HEROKU_CLOUD${CLEAR} "
  fi
}

PS1="
\$(return_prompt) ${LIGHT_BLUE}%n ${YELLOW}%*\
 ${WHITE}{${LIGHT_CYAN}%~${WHITE}}\
 ${PURPLE}\$(git_prompt_info)\$(cloud_info) -- ${CLEAR}${WHITE}${CLEAR}${WHITE}\

┖ \$ "

function zle-line-init zle-keymap-select {
  RPS1="${LIGHT_CYAN}${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}${WHITE}"
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

setopt inc_append_history
setopt share_history
# ignore duplicate history entries
setopt histignoredups
# ^^^^^^^^^^^^^^^^^^^^^ This might not make sense if we're tracking
# history and are interested in analyzing it later.
setopt EXTENDED_HISTORY

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
# setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# DJCP's direct customizations
HISTSIZE=500000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

export TERM=xterm-256color

export SHELL=/usr/bin/zsh
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'
# hitch

cloud() {
  eval "$(/usr/local/bin/ion-client shell)"
  cloud "$@"
}

# options picked up by asdf and probably gcc
export RUBY_CONFIGURE_OPTIONS="--with-jemalloc"
export CFLAGS="-march=native -O3"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# heroku autocomplete setup
CLI_ENGINE_AC_ZSH_SETUP_PATH=/home/dcollispuro/.cache/heroku/completions/zsh_setup && test -f $CLI_ENGINE_AC_ZSH_SETUP_PATH && source $CLI_ENGINE_AC_ZSH_SETUP_PATH;