#!/bin/bash

git clone git@github.com:Baltoli/notify.git
mkdir -p ~/.local/bin
cp notify/notify ~/.local/bin/notify
chmod +x ~/.local/bin/notify
rm -rf notify
