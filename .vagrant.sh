#!/bin/sh
##
###
# A simple script to initialize an isolated development environment
# for segfault.me
###
##
#
echo segfault.me is initializing...

# cd to the working directory
cd /vagrant
if [ ! -d ".git" ]; then
    echo There is no git repository at /vagrant!
    exit 1
fi

# Install gems without documentation or ri
echo "gem: --no-rdoc --no-ri" >~/.gemrc

# Install all gems required by segfault.me
bundle install --without production

# Seed development database
# Prepare testing database
# Run unit tests
