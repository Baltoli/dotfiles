# oh-my-zsh specifics
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(brew git ruby osx)
source $ZSH/oh-my-zsh.sh

# export bin paths
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$DOTFILES/bin:/usr/local/bin:$PATH
export PATH=$HOME/Documents/development/miniconda3/bin:$PATH

source $HOME/.profile

unsetopt ignoreeof

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo
if [[ -a $HOME/.localrc ]]
then
  source $HOME/.localrc
fi

# initialize autocomplete here, otherwise function won't be loaded
autoload -U compinit
compinit

DEFAULT_USER=brucecollie

# OPAM configuration
. /Users/brucecollie/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

unsetopt AUTO_CD
eval "$(rbenv init -)"

alias vim=nvim
export EDITOR="nvim"

open() {
  (xdg-open "$@" &) &> /dev/null
}

aga() {
  words=()
  word="$1"

  while [[ "$word" != "--" ]] && [[ "$#" -ne 0 ]]; do
    words+=$word
    shift
    word="$1"
  done

  if [[ "$word" = "--" ]]; then
    shift
  fi

  all=""
  for w in $words; do
    all="$w|$all"
  done
  all=${all[1,-2]}

  cmd=""
  for w in $words; do
    cmd="xargs -r -- ag $w $@ -l --no-color | $cmd"
  done
  cmd="${cmd[13,-1]}xargs -r -- ag '$all' $@"

  eval $cmd
}
export PATH="/usr/local/sbin:$PATH"

alias vim=nvim
export EDITOR=nvim
