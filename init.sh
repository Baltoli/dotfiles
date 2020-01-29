#!/bin/bash

for f in $(ls ./init/); do
  ./init/$f
done

echo "Linking..."
./link.sh
