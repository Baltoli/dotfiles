#!/usr/bin/env bash

FILES=(vimrc tmux.conf)

for f in ${FILES[@]}
do
  DOTFILE="$HOME/.$f"

  echo "Removing old file..."
  rm $DOTFILE
  echo "Linking $f..."
  ln -s $PWD/$f $DOTFILE
done
