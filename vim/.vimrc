" ~/.vimrc - Explicitly use defaults.vim to get modern baseline.
" Copyright (C) 2026 Thiago C Silva
" 
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <https://www.gnu.org/licenses/>.

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" General
set nocompatible
set encoding=utf-8
set number
set relativenumber
set cursorline
colorscheme quiet

filetype plugin indent on

augroup SetIndentation
  autocmd!
  autocmd FileType c,cpp setlocal et sw=2 sts=2 ts=8 tw=79 cc=80 cin
  autocmd FileType python,php,java setlocal et sw=4 sts=4 ts=8 tw=79 cc=80
  autocmd FileType sh,javascript,html,tex setlocal et sw=2 sts=2 ts=8 tw=79 cc=80
augroup END

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
  
runtime ftplugin/man.vim

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_list_hide = '.*\.swp$'

set ignorecase
set smartcase
set incsearch
set undofile
set undodir=~/.vim/undodir
