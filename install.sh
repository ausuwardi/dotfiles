#!/bin/bash

mypath="$(dirname "`readlink -f "$0"`")"


function create_link () {
    src=$1
    dest=$2

    source_path="${mypath}/${src}"
    dest_path="${HOME}/${dest}"

    if [[ -e "${dest_path}" ]]; then
        echo "${dest_path} already exist"
        return 1
    fi

    ln -vs "${source_path}" "${dest_path}"
}

create_link dot-config/nvim .config/nvim
create_link dot-config/i3 .config/i3
