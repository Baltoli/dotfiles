# oh-my-zsh specifics
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(brew git ruby osx)
source $ZSH/oh-my-zsh.sh

# export bin paths
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$DOTFILES/bin:/usr/local/bin:$PATH

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

export http_proxy=http://behistun.sec.cl.cam.ac.uk:8080
export HTTP_PROXY=http://behistun.sec.cl.cam.ac.uk:8080

# OPAM configuration
. /Users/brucecollie/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

function paste() {
  $@ 2>&1 | curl -F 'f:1=<-' ix.io
}

export GIT_KEY="6874810a2e442e168991595066e391a57a196922"
export LC_CTYPE=en_US.UTF-8
