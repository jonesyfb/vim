set encoding=utf-8

set number
set relativenumber
" reserve the sign column up front so LSP diagnostic signs don't trigger
" a full-window reflow (every line shifting right) when they first arrive
set signcolumn=yes

set runtimepath^=~/dotfiles/vim
set runtimepath+=~/dotfiles/vim/after
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent

syntax on

set colorcolumn=74

