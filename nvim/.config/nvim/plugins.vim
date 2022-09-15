" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

silent! if plug#begin('~/.local/share/nvim/plugged')
    " airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " colorschemes
    Plug 'flazz/vim-colorschemes'

    " editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " nerdtree
    Plug 'preservim/nerdtree'

    " vim-fugitive
    Plug 'tpope/vim-fugitive'

    " vim-surround
    Plug 'tpope/vim-surround'

    " floating terminal
    Plug 'voldikss/vim-floaterm'

    " notational-fzf for note-taking
    Plug 'alok/notational-fzf-vim'

    " elixir support
    Plug 'elixir-editors/vim-elixir'

    " Neo4j
    Plug 'neo4j-contrib/cypher-vim-syntax'

    " Terraform
    Plug 'hashivim/vim-terraform'

    " LSP and 'intellisense'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

    " vsnip for lsp-based snippets
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " Real time syntax check & linting
    Plug 'dense-analysis/ale'

    " ES-6
    Plug 'isRuslan/vim-es6'

    " Track time spent on editing files
    Plug 'wakatime/vim-wakatime'
    
    call plug#end()
endif
