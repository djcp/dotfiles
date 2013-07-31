# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi
# vi mode bindkey -v
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
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

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

weather_prompt() {
  cat ~/.cli-weather-forecast
}

PS1="
\$(return_prompt) ${LIGHT_BLUE}%n@%m ${YELLOW}%*\
 ${WHITE}{${LIGHT_CYAN}%~${WHITE}}\
 ${PURPLE}\$(git_prompt_info) -- ${CLEAR}${WHITE}\$(weather_prompt)${CLEAR}${WHITE}\

┖ \$ "

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# look for ey config in project dirs
export EYRC=./.eyrc

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

TERM=xterm-256color

export SHELL=/usr/bin/zsh
export PATH="$HOME/bin:$HOME/.rbenv/bin:$PATH:$HOME/code/spx/apache-maven-3.0.5/bin"
eval "$(rbenv init -)"
