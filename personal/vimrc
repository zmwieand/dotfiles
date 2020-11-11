set number
set nocompatible
set hlsearch
set colorcolumn=80 
set ruler
set rulerformat=[%l\:%c]
set showmatch

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" 2 tabs for yaml/sh/tsx files
autocmd FileType yaml setlocal ts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sw=2 expandtab

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight ColorColumn ctermbg=238

" For plugins
execute pathogen#infect()
