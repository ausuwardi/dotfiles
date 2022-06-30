#!/bin/bash

NVIM_HOME=${HOME}/.local/share/nvim
NVIM_VENV_DIR=${NVIM_HOME}/venv
NVIM_CONF_DIR=${HOME}/.config/nvim

if [[ ! -d ${NVIM_VENV_DIR} ]]; then
    python3 -m venv ${NVIM_VENV_DIR}
fi

${NVIM_VENV_DIR}/bin/pip3 install pynvim
${NVIM_VENV_DIR}/bin/pip3 install msgpack

mkdir -p ${HOME}/.local/share/nvim/plugged
curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall
