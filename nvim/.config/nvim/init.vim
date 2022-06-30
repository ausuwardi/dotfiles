
silent! if plug#begin('~/.local/share/nvim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'voldikss/vim-floaterm'

    Plug 'alok/notational-fzf-vim'

    Plug 'elixir-editors/vim-elixir'

    Plug 'dense-analysis/ale'
    Plug 'isRuslan/vim-es6'
    Plug 'SirVer/ultisnips'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'wakatime/vim-wakatime'
    
    call plug#end()
endif

" Editing stuff
syntax on
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent
autocmd Filetype gitcommit set tw=72
set number
set relativenumber
set laststatus=2       " Always display the statusline in all windows
set showtabline=2      " Always display the tabline, even if there is only one tab
set t_Co=256

let mapleader=","

" --- python infrastructure
let g:python3_host_prog="$HOME/.local/share/nvim/venv/bin/python3"

" --- fzf
nmap <Leader>F :Files<Enter>
nmap <Leader>g :Rg 

" --- NERDtree
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
"  auto open NERDTree when no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"  auto exit vim when NERDTree is the only pane
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" <Leader>f to open NERDTree
nmap <Leader>f :NERDTreeToggle<Enter>

" Color scheme
set background=dark
colorscheme gruvbox

" Airline
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled=1

" Linting
"let g:ale_fixers = {
"            \ 'javascript': ['eslint'],
"            \}
"let g:ale_linters = {
"            \ 'javascript': ['eslint'],
"            \}

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackgwardTrigger="<c-z>"

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
            \ '_': ['ale', 'buffer']
            \})

" Floaterm
nmap <Leader>t :FloatermToggle<Enter>
nmap <Leader>T :FloatermNew<Enter>

" notational-fzf-vim
let g:nv_search_paths = ['~/notes']
