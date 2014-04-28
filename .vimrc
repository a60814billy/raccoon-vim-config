" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
set t_Co=256
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('vim_starting')
set nocompatible               " Be iMproved
" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'

" Powerline
NeoBundle 'Lokaltog/vim-powerline'
" NERDTree
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
" Auto Complete pop
NeoBundle 'othree/vim-autocomplpop'
" Color Selector
NeoBundle 'c9s/colorselector.vim'

" Html5 syntax
NeoBundle 'othree/html5.vim'

" Prolog
NeoBundle 'adimit/prolog.vim'

" Ruby
NeoBundle 'vim-ruby/vim-ruby'

" Javascript
NeoBundle 'jelera/vim-javascript-syntax'

" snipmate
NeoBundle 'msanders/snipmate.vim'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Prolog syntax 
autocmd BufRead,BufNewFile *.pl set filetype=prolog
" Prolog Consult
autocmd FileType prolog nmap <F5> :w<CR> :!swipl %<CR>
" Ruby Interpreter
autocmd FileType ruby nmap <F5> :w<CR> :% w !ruby -w %<CR>
" C/C++ makefile
autocmd FileType c nmap <F5> :w<CR> :make<CR>

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set syntax=on 
" set background=dark
set number
set sw=4
set sts=4
set laststatus=2
set nobackup
set noswapfile
set guifont=Menlo\ 12
syntax on

let g:Powerline_symbols = 'fancy'
" let g:rehash2566=1
let NERDTreeShowBookmarks=1
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1

nmap <TAB> v>
nmap <S-TAB> v<
nmap sp :split<CR>
nmap vsp :vsplit<CR>
nmap q :q<CR>
nmap <C-t> :tabnew<CR>
nmap <F7> gT
nmap <F8> gt
nmap <F4> :qall<CR>
nmap > :10 wincmd ><CR>
nmap < :10 wincmd <<CR>
nmap + :5 wincmd +<CR>
nmap _ :5 wincmd -<CR>
vmap <TAB> >gv
vmap <S-TAB> <gv

nmap <F2> :NERDTreeTabsToggle<CR>
nmap <F3> :SelectColorS<CR>

colorscheme molokai
