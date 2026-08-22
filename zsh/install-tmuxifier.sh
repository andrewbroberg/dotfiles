#!/usr/bin/env bash

set -e

TMUXIFIER_DIR="$HOME/.tmux/plugins/tmuxifier"

if [ -d "${TMUXIFIER_DIR}" ]; then
    echo "tmuxifier already installed"
    exit 0
fi

echo "Installing tmuxifier"
git clone --depth=1 https://github.com/jimeh/tmuxifier.git "${TMUXIFIER_DIR}"
