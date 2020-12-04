#!/bin/bash

pip3 install --user pynvim
pip3 install --user msgpack

mkdir -p ${HOME}/.local/share/nvim/plugged
curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

