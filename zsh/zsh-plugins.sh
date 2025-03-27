#!/bin/bash

INSTALL_BASE=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo $INSTALL_BASE

if [ ! -d  "${INSTALL_BASE}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${INSTALL_BASE}/plugins/zsh-autosuggestions
fi

if [ ! -d  "${INSTALL_BASE}/plugins/zsh-syntax-highlighting" ]; then
    echo "Insalling zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${INSTALL_BASE}/plugins/zsh-syntax-highlighting
fi

if [ ! -d  "${INSTALL_BASE}/plugins/artisan" ]; then
    echo "Installing artisan"
    git clone https://github.com/jessarcher/zsh-artisan.git ${INSTALL_BASE}/plugins/artisan
fi
