" Fredrik's Vimrc

" vim-plug {{{
call plug#begin('~/.vim/plugged')

Plug 'leafgarland/typescript-vim'
Plug 'udalov/kotlin-vim'
Plug 'idris-hackers/idris-vim'
Plug 'ziglang/zig.vim'
Plug 'https://github.com/PyGamer0/vim-apl'

"nmap <C-&> <Plug>(TsuquyomiReferences)
"Plug 'Quramy/tsuquyomi'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

noremap <c-j> :call fzf#vim#grep("rg --column --line-number --no-heading --color=always -- ".shellescape(expand('<cword>')), 1, fzf#vim#with_preview('up', 'ctrl-/'), 1)<cr><cr>

"Mega treig
"Plug 'ludovicchabant/vim-gutentags'
"
Plug 'whonore/Coqtail'

call plug#end()
" }}}
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

        Bundle 'zah/nim.vim'

        Plugin 'Valloric/YouCompleteMe'
        let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_global_ycm_extra_conf.py'

        Plugin 'rust-lang/rust.vim'

        Plugin 'udalov/kotlin-vim'

        Plugin 'ziglang/zig.vim.git'

        Plugin 'leafgarland/typescript-vim'
        au BufNewFile,BufRead *.tsx set filetype=typescript

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
colorscheme desert
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

" Scanning hangs in rust files. This fixes that. I don't know what the
" drawbacks are. Haven't experienced any.
set complete-=i
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
set nonumber            " do not show line numbers
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

" }}}
" Leader stuff {{{
let mapleader =","   "leader is comma

" nnoremap <Leader>f :YcmCompleter FixIt <CR>
" nnoremap <Leader>d :YcmCompleter GetDoc <CR>
" nnoremap <Leader>t :YcmCompleter GetType <CR>
" save session
nnoremap <leader>s :mksession<CR>
" }}}
" Mappings {{{
" map <F9> :YcmCompleter FixIt<CR>
cmap <C-p> <Up>
cmap <C-n> <Down>

map <C-K> :py3f /opt/clang-format.py<cr>
imap <C-K> <c-o>:py3f /opt/clang-format.py<cr>

" Show list of tags when more than one match
nnoremap <C-]> g<C-]>
command Bd bp\|bd \#
" }}}
" statusline {{{
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=%#VertSplit#%{StatuslineGit()}
set statusline+=%#CursorLine#%<\ %f
set statusline+=\ %h%m%r%=%-14.(%p%%\ %l:%c%V%)

set laststatus=2
" }}}



au VimLeavePre * if v:this_session != '' | exec "mks! " . v:this_session | endif

" vim:foldmethod=marker:foldlevel=0
