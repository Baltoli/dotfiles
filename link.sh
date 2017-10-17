#!/usr/bin/env bash

FILES=(
  vimrc vim 
  tmux tmux.conf
  gitignore gitconfig.local
  oh-my-zsh zshrc
  latexmkrc
  config
)

for f in ${FILES[@]}
do
  DOTFILE="$HOME/.$f"

  echo "Removing old file..."
  rm -rf $DOTFILE
  echo "Linking $f..."
  ln -s $PWD/$f $DOTFILE
done
