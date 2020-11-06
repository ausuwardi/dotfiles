#!/bin/bash

mypath="$(dirname "`readlink -f "$0"`")"


function create_link () {
    source=$1
    dest=$2

    source_path="${mypath}/${source}"
    dest_path="${HOME}/${dest}"

    if [[ -e "${dest_path}" ]]; then
        echo "${dest_path} already exist"
        exit 1
    fi

    ln -vs "${source_path}" "${dest_path}"
}


create_link dot-config/nvim .config/nvim
