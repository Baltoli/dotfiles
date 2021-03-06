#!/usr/bin/env bash

FILES=(
  vimrc
  tmux.conf
  gitignore gitconfig.local
  oh-my-zsh zshrc
  latexmkrc
  config/nvim
  bin
)

for f in ${FILES[@]}
do
  DOTFILE="$HOME/.$f"

  echo "Removing old file..."
  rm -rf $DOTFILE
  echo "Linking $f..."
  ln -s $PWD/$f $DOTFILE
done
