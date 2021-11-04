# oh-my-zsh specifics
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(brew git ruby osx)
source $ZSH/oh-my-zsh.sh

# export bin paths
export PATH=$HOME/.bin:/usr/local/bin:$PATH

PYTHON_USER_BIN=$(python3 -c 'import site; print(site.USER_BASE + "/bin")')
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
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
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

eval "$(direnv hook zsh)"

PATH="/Users/brucecollie/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/brucecollie/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/brucecollie/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/brucecollie/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/brucecollie/perl5"; export PERL_MM_OPT;
if [ -e /home/bruce/.nix-profile/etc/profile.d/nix.sh ]; then . /home/bruce/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
