set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ===== PLUGINS =====
	" Useful utilities
	Plugin 'scrooloose/nerdtree'
	Plugin 'vifm/vifm.vim'
	" Plugin 'w0rp/ale'
	Plugin 'kien/ctrlp.vim'
	Plugin 'neoclide/coc.nvim'

	" Themeing
	Plugin 'vim-airline/vim-airline'
	" Plugin 'tomasiser/vim-code-dark'
	" Plugin 'ErichDonGubler/vim-sublime-monokai'
	" Plugin 'yous/vim-open-color'
	" Plugin 'chriskempson/vim-tomorrow-theme'
	" Plugin 'altercation/vim-colors-solarized'
	Plugin 'dylanaraps/wal.vim'
	Plugin 'edkolev/tmuxline.vim'

	" Plugin 'zah/nim.vim'
	" Plugin 'dart-lang/dart-vim-plugin'
	Plugin 'vim-scripts/indentpython.vim'
	" Plugin 'xuhdev/vim-latex-live-preview'
	Plugin 'phpactor/phpactor'

	Plugin 'Valloric/YouCompleteMe'
	" Plugin 'vim-syntastic/syntastic'

	" Git additions
	Plugin 'tpope/vim-fugitive'
	Plugin 'airblade/vim-gitgutter'

	" Floobits
	" Plugin 'floobits/floobits-neovim'

	" Distraction free mode
	Plugin 'junegunn/goyo.vim'

	" Typescript
	Plugin 'Quramy/tsuquyomi'
	Plugin 'leafgarland/typescript-vim'
	Plugin 'ianks/vim-tsx'
	" Plugin 'neoclide/coc-tsserver'

	" Python
	Plugin 'neoclide/coc-python'

	" Emmet
	" Plugin 'mattn/emmet-vim'

	" Docker
	Plugin 'kevinhui/vim-docker-tools'


call vundle#end()
filetype plugin indent on

" This needs to be between these lines
	let python_highlight_all=1

syntax on

" ===== COLORSCHEME =====
	" colorscheme codedark
	" colorscheme open-color
	" colorscheme Tomorrow
	" colorscheme oceandeep
	" colorscheme solarized
	colorscheme wal

" General settings
	set number relativenumber
	set nowrap
	set tabstop=4
	set shiftwidth=4

	set t_Co=256

" Enable mouse clicking
	set mouse=niv

" Pane moving
	nmap <C-h> <C-w>h
	nmap <C-j> <C-w>j
	nmap <C-k> <C-w>k
	nmap <C-l> <C-w>l

" Shortcuts
	nnoremap <leader>n :NERDTreeToggle<CR>
	nnoremap <leader>o :Vifm<CR>
	nnoremap <leader>t :terminal<CR>
	nnoremap <leader>\| :Goyo<CR>
	nnoremap <leader>d :DockerToolsToggle<CR>
	nnoremap <leader>g :Git<CR>

" Syntax for files
	autocmd BufRead,BufNewFile ejs set syntax=html
	autocmd BufRead,BufNewFile pl set syntax=prolog
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set syntax=groff

" Ctrl-P ignore
	let g:ctrl_p_custom_ignore = 'node_modules'

" Remove thousands of errors in lua files
	let g:ale_lua_luacheck_options = '--globals love'

" Tex Settings
	let g:Tex_MultipleCompileFormats = 'pdf'
	let g:Tex_DefaultTargetFormat = 'pdf'
	let g:livepreview_previewer = 'zathura'

" Airline symbol config
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

" Auto file commands
	autocmd BufWritePost * %s/\s\+$//e

" Navigation shortcuts
	" inoremap <Tab><Space> <Esc>/<++><Enter>"_c4l
	" vnoremap <Tab><Space> <Esc>/<++><Enter>"_c4l
	" map <Tab><Space> <Esc>/<++><Enter>"_c4l

" Groff shortcuts
	autocmd FileType nroff inoremap ,vec left [ pile {<Enter>  <++> above<Enter><++><Enter><Esc><<i} right ]<Esc>kk0i
	autocmd FileType nroff inoremap ,mat left [ matrix {<Enter>  ccol { <++> above <++> }<Enter>ccol { <++> above <++> }<Enter><Esc><<i} right ]<Esc>kk0i

" Coc extensions
	" CocInstall coc-tsserver

" YCM
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" Tmuxline Conf
	let g:tmuxline_preset = {
		\'a': '#S',
		\'b': ['#h', '#(whoami)', '#(uptime -p)'],
		\'win': ['#I', '#W'],
		\'cwin': ['#I', '#W'],
		\'y': ['#(free --si -h | awk ''/Mem:/ { print $3 }'')', '#(acpi | awk -F "[ ,]" ''{ print $5 " " $7 }'')', '#(date "+%d %b %Y")'],
		\'z': '#(date "+%H:%M")' }

