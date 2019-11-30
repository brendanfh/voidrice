set nocompatible
filetype off

call plug#begin()
" ===== PLUGINS =====
    " Useful utilities
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'
	Plug 'norcalli/nvim-colorizer.lua'

    " Auto complete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'donRaphaco/neotex', { 'for': 'tex' }

    " Themeing
    Plug 'vim-airline/vim-airline'
    Plug 'tomasiser/vim-code-dark'
    Plug 'dylanaraps/wal.vim'
    Plug 'edkolev/tmuxline.vim'
	Plug 'yasukotelin/shirotelin'
	Plug 'cocopon/iceberg.vim'

	" Plug 'ryanoasis/vim-devicons'

	" Language specific
    Plug 'zah/nim.vim'
    " Plug 'alaviss/nim.nvim'
    " Plug 'dart-lang/dart-vim-plugin'
    " Plug 'vim-scripts/indentpython.vim'
    " Plug 'xuhdev/vim-latex-live-preview'
    " Plug 'phpactor/phpactor'
    Plug 'leafo/moonscript-vim'
    Plug 'kchmck/vim-coffee-script'

    " Git additions
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Floobits
    " Plug 'floobits/floobits-neovim'

    " Distraction free mode
    Plug 'junegunn/goyo.vim'

    " Docker
    Plug 'kevinhui/vim-docker-tools'

    " Note taking
    " Plug 'xolox/vim-notes'
    " Plug 'xolox/vim-misc'

    " Floating Terminal
    Plug 'voldikss/vim-floaterm'

    " NERDTree Git
    Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
filetype plugin indent on

syntax on

" General settings
    set number relativenumber
    set nowrap
    set tabstop=4
    set shiftwidth=4

	" set t_Co=256
	set termguicolors

	set cursorline

" ===== COLORSCHEME =====
	" set background=dark
	" set background=light

	colorscheme iceberg
	" colorscheme shirotelin
    " colorscheme codedark
    " colorscheme open-color
    " colorscheme Tomorrow
    " colorscheme oceandeep
    " colorscheme solarized
    " colorscheme wal

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

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = ' '

" Auto file commands
    autocmd BufWritePost * silent! %s/\s\+$//e
    " autocmd BufWritePost * silent! %s/\t/    /ge

" Navigation shortcuts
    " inoremap <Tab><Space> <Esc>/<++><Enter>"_c4l
    " vnoremap <Tab><Space> <Esc>/<++><Enter>"_c4l
    " map <Tab><Space> <Esc>/<++><Enter>"_c4l

" Groff shortcuts
    autocmd FileType nroff inoremap ,vec left [ pile {<Enter>  <++> above<Enter><++><Enter><Esc><<i} right ]<Esc>kk0i
    autocmd FileType nroff inoremap ,mat left [ matrix {<Enter>  ccol { <++> above <++> }<Enter>ccol { <++> above <++> }<Enter><Esc><<i} right ]<Esc>kk0i

" Coc Stuff
    command! -nargs=0 Format :call CocAction('format')
    inoremap <silent><expr> <C-space> coc#refresh()

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    set hidden
    set updatetime=300
    set shortmess+=c
    set signcolumn=yes

    au TextChanged,TextChangedI,TextChangedP * :call coc#refresh()

" Colorizer
	lua require'colorizer'.setup({'css';'scss';'sass';'html';'js';'ts';},{mode='foreground'})

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

    nmap <Space>tn :tabnew<CR>
    nmap <Space>td :tabclose<CR>
    nmap <Space>th :tabprev<CR>
    nmap <Space>tl :tabnext<CR>

    nmap <Space>bb :buffers<CR>:buffer!<Space>
    nmap <Space>bn :enew!<CR>
    nmap <Space>bh :bprevious!<CR>
    nmap <Space>bl :bnext!<CR>
    nmap <Space>bd :bdelete<CR>

	nmap <Space>fl :lnext<CR>
	nmap <Space>fh :lprev<CR>
	nmap <Space>ff :lvimgrep '

" Floating Term
    noremap <silent> <F12> :FloatermToggle<CR>
    noremap! <silent> <F12> <Esc>:FloatermToggle<CR>
    tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>
    let g:floaterm_position = "center"
    let g:floaterm_winblend = 10

" Floating fzf
    let g:height = float2nr(&lines * 0.9)
    let g:width = float2nr(&columns * 0.95)
    let g:preview_width = float2nr(&columns * 0.7)
    let g:fzf_buffers_jump = 1
    let g:fzf_layout = { 'window': 'call FloatingFZF(' . g:width . ',' . g:height . ')' }
    let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
    let $FZF_DEFAULT_OPTS=" --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4 --preview 'if file -i {}|grep -q binary; then file -b {}; else bat --style=changes --color always --line-range :40 {}; fi' --preview-window right:" . g:preview_width

    function! FloatingFZF(width, height)
      let buf = nvim_create_buf(v:false, v:true)
      call setbufvar(buf, '&signcolumn', 'no')

      let horizontal = float2nr((&columns - a:width) / 2)
      let vertical = 1

      let opts = {
            \ 'relative': 'editor',
            \ 'row': vertical,
            \ 'col': horizontal,
            \ 'width': a:width,
            \ 'height': a:height,
            \ 'style': 'minimal'
            \ }

      call nvim_open_win(buf, v:true, opts)
    endfunction

    nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
