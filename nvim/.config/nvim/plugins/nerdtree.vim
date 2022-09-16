" NERDtree
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

