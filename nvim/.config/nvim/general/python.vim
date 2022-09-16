" Python infrastructure
let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
let venv_dir = data_dir.'/venv'

if empty(glob(venv_dir))
    echo 'Initializing python3 venv'
    silent execute '!mkdir -p '.data_dir
    silent execute '!python3 -m venv '.venv_dir
    silent execute '!'.venv_dir.'/bin/pip3 install pynvim msgpack'
endif

let g:python3_host_prog="$HOME/.local/share/nvim/venv/bin/python3"

