#!/bin/bash

#Script to run after adding a deb file to the pool
#
#Created files:
#   -Packages
#   -Packages.gz
#   -Release
#   -Release.gpg
#   -InRelease

#Package files
package_loc=$(git rev-parse --show-toplevel)/repository/dists/testing/main/binary-amd64
root_loc=$(git rev-parse --show-toplevel)
rm "$package_loc"/*
cd $root_loc/repository
dpkg-scanpackages -m pool/testing > "$package_loc"/Packages
cat "$package_loc"/Packages | gzip -9 > "$package_loc"/Packages.gz

#Release files
release_loc=$(git rev-parse --show-toplevel)/repository/dists/testing
sign="Laurens Bruins"
cd "$release_loc"
$root_loc/scripts/generate-release-testing.sh > Release
cat $root_loc/KEY.gpg | gpg --import
cat "$release_loc"/Release | gpg --default-key "$sign" -abs > "$release_loc"/Release.gpg
cat "$release_loc"/Release | gpg --default-key "$sign" -abs --clearsign > "$release_loc"/InRelease

