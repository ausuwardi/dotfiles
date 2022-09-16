set nocompatible

" General
source ~/.config/nvim/general/editor.vim
source ~/.config/nvim/general/python.vim
source ~/.config/nvim/general/keybindings.vim

" Plugins
let g:ax_plug_initiating = 'n'
source ~/.config/nvim/vim-plug/plugins.vim
if g:ax_plug_initiating == 'n'
    source ~/.config/nvim/plugins/fzf.vim
    source ~/.config/nvim/plugins/nerdtree.vim
    source ~/.config/nvim/plugins/color_scheme.vim
    source ~/.config/nvim/plugins/airline.vim
    source ~/.config/nvim/plugins/floaterm.vim
    source ~/.config/nvim/plugins/notational_fzf.vim

    " LSP Configuration
    source ~/.config/nvim/lsp/lspconfig.vim
    luafile ~/.config/nvim/lsp/compe-config.lua
    " Per-language LSP configuration, see:
    "   https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    luafile ~/.config/nvim/lsp/python-ls.lua

endif

