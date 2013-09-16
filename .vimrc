""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Bundle 'tsukkee/unite-tag'
" Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'Shougo/vimproc'
Bundle 'derekwyatt/vim-scala'
Bundle 'Yggdroot/indentLine'
Bundle 'PeterRincker/vim-argumentative'
Bundle 'Shougo/unite-outline'
Bundle 'Shougo/unite.vim'
" Bundle 'arecarn/crunch'
Bundle 'b4winckler/vim-angry'
Bundle 'baabelfish/a.vim'
" Bundle 'chrisbra/NrrwRgn'
" Bundle 'dag/vim-fish'
Bundle 'glts/vim-textobj-comment'
Bundle 'jwhitley/vim-matchit'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'kurkale6ka/vim-pairs'
Bundle 'vim-scripts/Auto-Pairs'
" Bundle 'mattn/emmet-vim'
Bundle 'mhinz/vim-signify'
Bundle 'mhinz/vim-startify'
" Bundle 'mrtazz/DoxygenToolkit.vim'
" Bundle 'vim-scripts/VisIncr' # Incr other than numbers
" Bundle 'vim-scripts/ZoomWin'
" Bundle 'vim-scripts/django.vim'
Bundle 'AndrewRadev/switch.vim'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'baabelfish/vim-droid256'
Bundle 'bling/vim-airline'
Bundle 'drmikehenry/vim-fixkey'
Bundle 'gmarik/vundle'
Bundle 'gregsexton/gitv'
Bundle 'junegunn/vim-easy-align'
Bundle 'kana/vim-arpeggio'
Bundle 'pangloss/vim-javascript'
Bundle 'paradigm/SkyBison'
Bundle 'rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tomasr/molokai'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Bck'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/Vimchant'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'guns/vim-clojure-static'
" Bundle 'vim-scripts/slimv.vim' "Korvaa vimClojuren?

filetype plugin indent on
setlocal spell spelllang=en_us

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  scriptencoding utf-8
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set backspace=indent,eol,start
set clipboard+=unnamedplus
set expandtab
set fillchars+=vert:│
set gdefault
set hidden
set history=100
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=""
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:█
set nobackup
set noerrorbells
set nofoldenable
set noshowmode
set nospell
set noswapfile
set notimeout
set novisualbell
set nowrap
set nrformats-=octal
set shortmess+=filmnrxoOtTI
set smartcase
set smartindent
set smarttab
set ttimeout
set ttimeoutlen=0
" set wildignore+=*/public/components/*,*/bower_components/*,*/node_modules/*,*/site-packages/*,*/tmp/*,*.so,*.swp,*.zip,*/doxygen/*,*.o,*.pyc,*.aux,*.toc,*.tar,*.gz,*.svg,*.mdr,*.mdzip,*.blg,*.bbl,*.out,*.log,*.zip,*.pdf,*.bst,*.jpeg,*.jpg,*.png,*.a,*.so,*.exe,*.dll,*.bak,*.,*.class,*.meta,*.lock,*.orig,*.jar,*/hg/*,git/*,*/bzr/*
" set wildignore+=*/public/*
set wildmenu
set wildmode=longest,list
set wildignorecase
set wrapmargin=0
set nonumber
set relativenumber

" Voi jäytää ehkä
set regexpengine=0

" Tab settings
set numberwidth=2
set shiftwidth=2
set softtabstop=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:droid_transparent = 0
let g:droid_day = 0

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" match ExtraWhitespace /\S\+\s\+$/
" match ExtraWhitespace /\s\+$/
" match ExtraWhitespace /[^\t]\zs\t\+/
" match ExtraWhitespace /\s\+$\| \+\ze\t/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * redraw!

syntax on
if has("gui_running")
  colorscheme droid256
elseif &t_Co == 256 
  colorscheme droid256
endif
" hi NonText ctermfg=160 ctermbg=233 cterm=none

" Color erase fix
if &term =~ '256color'
  set t_ut=
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = 'ö'
" Pakko korjaukset
nnoremap ' `
nnoremap Y y$
set pastetoggle=<M-p>
nnoremap j gj
nnoremap k gk

" Ikkunoiden mälväys altin kanssa
nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l
nnoremap <M-H> H
nnoremap <M-J> J
nnoremap <M-K> K
nnoremap <M-L> L
nnoremap <M-q> <C-w>c
nnoremap <M-c> :tabclose<cr>:echo ""<cr>
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
nnoremap <M-w> <C-w><C-w>

" Liikuttaa parametreja
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight

" Undohistoria. Itse en käytä.
nnoremap <F5> :GundoToggle<CR>

" Sama kun sublimen C-r
nnoremap <silent><space>f m':Unite -hide-status-line outline<CR>
" Sama kun sublimen C-p
nnoremap <silent><space>p :Unite -silent file_rec/async<CR>
nnoremap <silent><space>y :Unite -silent history/yank<CR>
nnoremap <silent><space>s :Startify<CR>

" Projektissa ettimiseen Ackilla
" <C-r><C-w> ottaa kursorin alla olevan sanan -> :h <C-r>
nnoremap <silent><space>bf :Bck FIXME<CR>
nnoremap <silent><space>bt :Bck TODO<CR>
nnoremap <silent><space>bw :Bck <C-r><C-w><CR>

" Lisää ja vähentää seuraavasta numerosta
nnoremap + <C-a>
nnoremap - <C-x>

" å togglee kommentin
nnoremap <silent>å :TComment<CR>
vnoremap å :TComment<CR>

" Näppärä nopea makronappi
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm! 

" Avaa git diffin
nnoremap <silent><space>t :Gitv<CR>
inoremap <C-c> <ESC>

" let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']
let g:UltiSnipsExpandTrigger="<c-J>"
" let g:UltiSnipsListSnippets="<c-$>"
" let g:UltiSnipsJumpForwardTrigger="<c-J>"
" let g:UltiSnipsJumpBackwardTrigge="<c-k>"

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

set pastetoggle=<M-p>

let g:airline_detect_whitespace=0
let g:airline_linecolumn_prefix = '¶'
let g:airline_branch_prefix = ''
let g:airline_paste_symbol = 'ρ'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_powerline_fonts=0
let g:airline_enable_branch=1
let g:airline_enable_syntastic=0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jslint']
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
let g:airline_theme='badwolf'
let g:airline_detect_modified=1
let g:airline_exclude_preview = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'v',
    \ 'V'  : 'V',
    \ '^V' : '^V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }

let g:skybison_fuzz = 1

let g:signify_sign_overwrite = 0
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'
let g:signify_sign_add               = '»'
let g:signify_sign_change            = '∙'
let g:signify_sign_delete            = '«'
let g:signify_sign_delete_first_line = '-'

let g:indentLine_color_term = 237
let g:indentLine_char = '│'
vnoremap ¤ :g/.*/norm! 
if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_split_rule = 'bot'
let g:unite_winheight = 15

call unite#custom_source('menu', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('source', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('outline', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('history/yank', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('file_rec/async', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('file_rec/async', 'ignore_pattern', '\(.*/\(\(public\|dist\|app\)\/components/\|node_modules\)\|\.grunt\).*')

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_identifier_chars = '_-/.><'
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_semantic_triggers = { 'clojure' : ['(', '/'] }

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
set guioptions-=T  "remove toolbar
nnoremap K i<CR><Esc>k$
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
