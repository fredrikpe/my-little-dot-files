" Fredrik's Vimrc

" Vundle {{{
function! s:InitializeVundle()
    if !isdirectory($HOME.'/.vim/bundle/Vundle.vim/')
        echo "Vundle is not installed."
        return
    else
        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()

        " let Vundle manage Vundle, required
        Bundle 'VundleVim/Vundle.vim'

        Plugin 'Valloric/YouCompleteMe'
        let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_global_ycm_extra_conf.py'

        Plugin 'tpope/vim-fugitive'
        set diffopt+=vertical

        Plugin 'weynhamz/vim-plugin-minibufexpl'

        Plugin 'rust-lang/rust.vim'

        " All of your Plugins must be added before the following line
        call vundle#end()            " required
        filetype plugin indent on    " required
        return
    endif
endfunction
call s:InitializeVundle()
" }}}
" Colors {{{
syntax enable
" colorscheme 
" }}}
" Misc {{{
set nocompatible                " be iMproved, required
filetype off                    " required
set ttyfast                     " faster redraw
set backspace=indent,eol,start
let $BASH_ENV = '~/.bash_aliases'

set nobackup
set noswapfile

" Undo & History
set hidden              " Save undo between buffers
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set history=1000

let loaded_matchparen = 1  " Don't highlight matching delimiter
" }}}
" Spaces & Tabs {{{
set tabstop=4
set expandtab           " use spaces for tabs
set softtabstop=4
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}
" UI Layout {{{
set number              " show line numbers
set norelativenumber
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set showmatch           " higlight matching parenthesis
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set smartcase           " case sensitive when uppercase is used
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
set wildignorecase      " case insensitive file finding
set fileignorecase
nmap <silent> ,/ :nohlsearch<CR>
" }}}
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10    " start with fold level of 1
" }}}
" Navigation {{{
nnoremap j gj
nnoremap k gk
nnoremap B ^

" Splits
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tabs switches buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" Ctrl+c deletes buffer and switches to next
nnoremap <C-c> :bp\|bd #<CR>
noremap E $
" }}}
" Leader stuff {{{
let mapleader =","   "leader is comma

nnoremap <Leader>f :YcmCompleter FixIt <CR>
nnoremap <Leader>d :YcmCompleter GetDoc <CR>
nnoremap <Leader>t :YcmCompleter GetType <CR>
" save session
nnoremap <leader>s :mksession<CR>
" }}}
" Mappings {{{
nmap ; :
map <F9> :YcmCompleter FixIt<CR>
cmap <C-p> <Up>
cmap <C-n> <Down>

map <C-K> :py3f /opt/clang-format.py<cr>
imap <C-K> <c-o>:py3f /opt/clang-format.py<cr>

" Show list of tags when more than one match
nnoremap <C-]> g<C-]>
" }}}


au VimLeavePre * if v:this_session != '' | exec "mks! " . v:this_session | endif

" vim:foldmethod=marker:foldlevel=0
