set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
" Plugin 'tomasiser/vim-code-dark'
" Plugin 'ErichDonGubler/vim-sublime-monokai'
" Plugin 'floobits/floobits-neovim'
Plugin 'edkolev/tmuxline.vim'
" Plugin 'yous/vim-open-color'
" Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'chriskempson/vim-tomorrow-theme'
" Plugin 'dart-lang/dart-vim-plugin'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dylanaraps/wal.vim'
" Plugin 'zah/nim.vim'
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/goyo.vim'

call vundle#end()
filetype plugin indent on

let python_highlight_all=1
syntax on

" colorscheme codedark
" colorscheme open-color
" colorscheme Tomorrow
" colorscheme oceandeep
" colorscheme solarized
colorscheme wal

set number relativenumber
set nowrap
set tabstop=4
set shiftwidth=4

set t_Co=256
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :terminal<CR>
nnoremap <leader>\| :Goyo<CR>

autocmd FileType ejs set syntax=html
autocmd FileType pl set syntax=prolog

let g:ctrl_p_custom_ignore = 'node_modules'

let g:ale_lua_luacheck_options = '--globals love'

let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:livepreview_previewer = 'zathura'

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:tmuxline_powerline_separators = 1

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

