#!/usr/bin/env bash

set -e

OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_REPO="https://github.com/ohmyzsh/ohmyzsh.git"

if [ -f "${OMZ_DIR}/oh-my-zsh.sh" ]; then
    echo "Oh My Zsh already installed"
    exit 0
fi

echo "Installing Oh My Zsh"

# zsh-plugins.sh may have already created $OMZ_DIR/custom/plugins, so a plain
# `git clone` would fail on the non-empty directory. Initialise in place and
# hard reset instead, which leaves the cloned custom plugins untouched.
mkdir -p "${OMZ_DIR}"
if [ ! -d "${OMZ_DIR}/.git" ]; then
    git -c init.defaultBranch=master init -q "${OMZ_DIR}"
    git -C "${OMZ_DIR}" remote add origin "${OMZ_REPO}"
fi

git -C "${OMZ_DIR}" fetch --depth=1 origin master
git -C "${OMZ_DIR}" reset --hard origin/master
