#!/bin/bash

# delete package-lock.json
rm package-lock.json

# delete node_modules directory
rm -r node_modules

# parse the package names in package.json
packages="$(sed -n 's/.*"\([^"]*\)": "^.*/\1/p' ./package.json)"

# map the package names to an array
mapfile -t packageArray <<< "$packages"

# install the latest version of the packages
for val in "${packageArray[@]}"; do
    npm i -D "$val"@latest
done