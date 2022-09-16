" auto-install vim-plug
let site_dir = has('nvim') ? stdpath('data').'/site' : '~/.vim'
let autoload_dir = site_dir.'/autoload'
let plugs_dir = site_dir.'/plugged'

if empty(glob(autoload_dir.'/plug.vim'))
    silent execute '!curl -fLo '.autoload_dir.'/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let g:ax_plug_initiating='y'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(plugs_dir)
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

    " Terraform
    Plug 'hashivim/vim-terraform'

    " LSP and 'intellisense'
    " For now, it's neovim only
    if has('nvim')
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/nvim-compe'

        " vsnip for lsp-based snippets
        Plug 'hrsh7th/vim-vsnip'
        Plug 'hrsh7th/vim-vsnip-integ'
    endif

    " Real time syntax check & linting
    Plug 'dense-analysis/ale'

    " ES-6
    Plug 'isRuslan/vim-es6'

    " Track time spent on editing files
    Plug 'wakatime/vim-wakatime'
    
call plug#end()
