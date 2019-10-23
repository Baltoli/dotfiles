# oh-my-zsh specifics
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(brew git ruby osx)
source $ZSH/oh-my-zsh.sh

# export bin paths
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$DOTFILES/bin:/usr/local/bin:$PATH

PYTHON_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PATH=$PYTHON_USER_BIN:$PATH

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

unsetopt AUTO_CD

alias vim=nvim
export EDITOR="nvim"

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use default
}

nvm() {
  lazynvm
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}
