set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Syntax checker
Plugin 'scrooloose/syntastic'

"Fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

"Filetype specific indents
Plugin 'editorconfig/editorconfig-vim'

"Bracket pairing
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on
syntax on

" Ignore various cache/vendor folders
set wildignore+=*/node_modules/*,*/dist/*,*/__pycache__/*

" Ignore C/C++ Object files
set wildignore+=*.o

" Ignore generated C/C++ Qt files
set wildignore+=moc_*.cpp,moc_*.h

" Ignore generated C/C++ Qt files
set wildignore+=moc_*.cpp,moc_*.h
" set wildignore+=*/lib/*

set noswapfile
set number
set nowrap
set backspace=indent,eol,start
set incsearch
set showmode
set nocompatible
filetype on
set wildmenu
set ruler
set lz
set hid
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set ai
set si
set cin
set cursorline
set numberwidth=6
set encoding=utf-8
set so=999
set hlsearch
set splitright
let &cc=join(range(80,500),",")
set rnu
set ignorecase
set winwidth=30
set winminwidth=30
set history=1000
if &t_Co == 256
    colorscheme seoul256
else
    colorscheme ron
endif
filetype plugin on

"status line
set statusline=%t%m%r%h%w\ 
set statusline+=%=
set statusline+=\ Ln\ %l/%L\ Col\ %c 
highlight StatusLine ctermfg=white ctermbg=67 cterm=None term=None
highlight StatusLineNC ctermfg=lightgrey ctermbg=239 cterm=None term=None
set laststatus=2

" Store an undo buffer in a file in $HOME/.vimundo
set undofile
set undodir=$HOME/.vimundo
set undolevels=1000
set undoreload=10000

"remaps
nnoremap ; :
nnoremap Q <nop>
nnoremap <F1> <nop>
map <S-k> <Nop>
nnoremap a i
nnoremap z u
nnoremap y :redo<CR>
nnoremap u <nop>
nnoremap = <C-W>>
nnoremap - <C-W><
nnoremap <C-F> ?
nnoremap <C-G> :call HLtoggle()<CR>
nnoremap . N
nnoremap , n
nnoremap s :w<CR>:echo "saved"<CR>
nnoremap <expr> q !&mod ? ':q!<CR>' : '' 
nnoremap <C-W> <C-W>w
nnoremap <C-Q> <C-W>h
nnoremap <C-O> :vsp 
nnoremap <C-Up> <C-W>k
nnoremap <C-Down> <C-W>j
nnoremap <C-Left> <C-W>h
nnoremap <C-Right> <C-W>l
nnoremap <C-N> :vnew<CR><C-W>L<C-W>200h
nnoremap m :vertical resize 20<CR>
nnoremap <expr> x winwidth('%') < 86 ? ':vertical resize 86<CR>' : ''
nnoremap <C-E> <C-W>200h
nnoremap <expr> P &paste ? ':set nopaste<CR>' : ':set paste<CR>'
nnoremap c yy
nnoremap v p
nnoremap V v
nnoremap <F5> :w<CR>:SyntasticCheck<CR>
nnoremap <C-Space> :echo "wtheck ctrl space works"<CR>
nnoremap <C-0> <C-W>L
vnoremap c y
nnoremap <C-T> :new<CR><C-W>L
nnoremap <F11> :call Fs()<CR>
nnoremap <S-F6> :call Search_replace()<CR> 

"Syntastic
"let g:syntastic_mode_map = { 'mode': 'passive',     
"                          \ 'active_filetypes': [],     
"                          \ 'passive_filetypes': [] } 
"let g:syntastic_auto_loc_list=1     
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler = "gcc"
let g:syntastic_c_compiler_options = "-Wall -Werror -ansi -pedantic"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_cpp_checker = 0
let g:syntastic_cpp_checkers=['']
autocmd FileType qf setlocal wrap
autocmd BufWritePost *.c SyntasticCheck

"Switch between .c and .h
nnoremap <Space> <nop>
map <Space> <leader>
au FileType c nmap <leader>h :call C_H()<CR>
au FileType h nmap <leader>h :call C_H()<CR>

"CtrlP most recent files mode
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'cra'

"Netrw
autocmd VimEnter * Vexplore
let g:netrw_winsize=30                                                                                                      
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_banner=0
let g:netrw_preview=1
let g:netrw_keepdir=0

"AutoComplete
set completeopt=menu,menuone,noinsert
inoremap <expr> <CR> pumvisible() ? '<C-Y>' : '<CR>'
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-P>\<C-N>", 'n')
    end
endfun

"TabComplete
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

"switch between .c and .h
function! C_H()
  if match(expand("%"), "\.c$") > 0
    let file=substitute(expand("%:t"), '\.c', '.h', "")
  endif
  if match(expand("%"), "\.h$") > 0
    let file=substitute(expand("%:t"), '\.h', '.c', "")
  endif
  if exists("file")
    exe "e ".fnameescape(expand('%:p:h')."\/".file)
  endif
endfun

"toggle fullscreen
let g:fs_f=0
let g:fs_l=1
function! Fs()
    let g:fs_l=line(".")
    if g:fs_f
        if &mod
            exe "normal :w\<CR>"
        endif
        tabclose
        exe g:fs_l
    else
        exe "tabnew %"
        exe g:fs_l
    endif
    let g:fs_f = !g:fs_f
endfun

"toggle highlight
function! HLtoggle()
    if (@/ == '')
        let @/ = expand("<cword>")
    else
        let @/ = ''
    endif
endfunc

"replace all instances of a word
function! Search_replace()
    "let @/ = expand("<cword>")
    let word = substitute(input(expand("<cword>"). " ->")," ","","")
    exe "%s/\\<".expand("<cword>")."\\>/".word."/g"
    let @/ = word
endfun









