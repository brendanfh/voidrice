set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ===== PLUGINS =====
	" Useful utilities
	Plugin 'scrooloose/nerdtree'
	Plugin 'vifm/vifm.vim'
	Plugin 'kien/ctrlp.vim'
	Plugin 'neoclide/coc.nvim'

	" Auto complete
	Plugin 'neomake/neomake'
	Plugin 'Shougo/deoplete.nvim'
	Plugin 'Shougo/deoplete-clangx'
	Plugin 'deoplete-plugins/deoplete-jedi'
	Plugin 'donRaphaco/neotex', { 'for': 'tex' }

	" Themeing
	Plugin 'vim-airline/vim-airline'
	Plugin 'dylanaraps/wal.vim'
	Plugin 'edkolev/tmuxline.vim'

	Plugin 'zah/nim.vim'
	" Plugin 'alaviss/nim.nvim'
	" Plugin 'dart-lang/dart-vim-plugin'
	Plugin 'vim-scripts/indentpython.vim'
	" Plugin 'xuhdev/vim-latex-live-preview'
	" Plugin 'phpactor/phpactor'
	Plugin 'leafo/moonscript-vim'
	Plugin 'kchmck/vim-coffee-script'

	" Git additions
	Plugin 'tpope/vim-fugitive'
	Plugin 'airblade/vim-gitgutter'

	" Floobits
	" Plugin 'floobits/floobits-neovim'

	" Distraction free mode
	Plugin 'junegunn/goyo.vim'

	" Typescript
	" Plugin 'Quramy/tsuquyomi'
	" Plugin 'leafgarland/typescript-vim'
	" Plugin 'ianks/vim-tsx'
	" Plugin 'neoclide/coc-tsserver'

	" Python
	Plugin 'neoclide/coc-python'

	" Emmet
	" Plugin 'mattn/emmet-vim'

	" Docker
	Plugin 'kevinhui/vim-docker-tools'

	" Note taking
	Plugin 'xolox/vim-notes'
	Plugin 'xolox/vim-misc'

	" Floating Terminal
	Plugin 'voldikss/vim-floaterm'

	" NERDTree Git
	Plugin 'Xuyuanp/nerdtree-git-plugin'


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

" Tab moving
	nmap <C-n> :tabprev<CR>
	nmap <C-m> :tabnext<CR>

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

" Deoplete and Neomake
	let g:deoplete#enable_at_startup = 1
	let g:neotex_delay = 1

	call neomake#configure#automake('nrwi', 1)
	let g:neomake_warning_sign = {
	  \ 'text': '--',
	  \ 'texthl': 'WarningMsg',
	  \ }
	let g:neomake_error_sign = {
	  \ 'text': '>>',
	  \ 'texthl': 'ErrorMsg',
	  \ }

" Ctrl-P ignore
	let g:ctrl_p_custom_ignore = 'node_modules'

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

" Tmuxline Conf
	let g:tmuxline_preset = {
		\'a': '#S',
		\'b': ['#h', '#(whoami)', '#(uptime -p)'],
		\'win': ['#I', '#W'],
		\'cwin': ['#I', '#W'],
		\'y': ['#(free --si -h | awk ''/Mem:/ { print $3 }'')', '#(acpi | awk -F "[ ,]" ''{ print $5 " " $7 }'')', '#(date "+%d %b %Y")'],
		\'z': '#(date "+%H:%M")' }

	let s:previousMode = ""
	let s:tmuxenv = $TMUX
    let s:tmux = 0
    if (s:tmuxenv != "")
        let s:tmux = 1
    endif
    function! ChangeTmuxline()
        if s:tmux == 1
            let currentMode=mode()
            if s:previousMode != currentMode
                if currentMode == "i" || currentMode == "ic" || currentMode == "ix" || currentMode == "R" || currentMode == "Rx" || currentMode == "Rc" || currentMode == "Rv"
                    :Tmuxline airline_insert
                elseif currentMode == "n" || currentMode == "niR" || currentMode == "niI" || currentMode == "niV" || currentMode == "no" || currentMode == "nov" || currentMode == "noV" || currentMode == "noCTRL-V" || currentMode == "c" || currentMode == "ce" || currentMode == "cv" || currentMode == "r" || currentMode == "rm" || currentMode == "r?" || currentMode == "!" || currentMode == "t"
                    :Tmuxline airline
                elseif currentMode == "v" || currentMode == "V" || currentMode == "CTRL-V" || currentMode == "s" || currentMode == "S" || currentMode == "CTRL-S"
                    :Tmuxline airline_visual
                endif
                let s:previousMode=currentMode
            endif
        endif
        return ""
	endfunction

	let g:airline_section_z = '%{ChangeTmuxline()} %p%% %l:%c '

" Emacs like key bindings
	nmap <Space>wh <C-w>h
	nmap <Space>wl <C-w>l
	nmap <Space>wj <C-w>j
	nmap <Space>wk <C-w>k

	nmap <Space>w[ <C-w><
	nmap <Space>w] <C-w>>
	nmap <Space>w{ <C-w>+
	nmap <Space>w} <C-w>-

	nmap <Space>wv :vnew<CR>
	nmap <Space>ws :new<CR>
	nmap <Space>wd :q<CR>

	nmap <Space>bb :buffers<CR>:buffer<Space>
	nmap <Space>bn :enew<CR>

" Floating Term
	noremap <silent> <F12> :FloatermToggle<CR>i
	noremap! <silent> <F12> <Esc>:FloatermToggle<CR>i
	tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>
	let g:floaterm_background = "#000000"
	let g:floaterm_position = 'center'
