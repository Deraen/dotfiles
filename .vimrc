" NeoBundle:
" git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'


NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'Deraen/seoul256.vim'
NeoBundle 'PeterRincker/vim-argumentative'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {'build': {'unix': 'make'}}
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Valloric/YouCompleteMe', {'build': {'unix': './install.sh --clang-completer --system-libclang'}}
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'b4winckler/vim-angry'
NeoBundle 'baabelfish/a.vim'
NeoBundle 'baabelfish/vim-droid256'
NeoBundle 'bling/vim-airline'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'drmikehenry/vim-fixkey'
NeoBundle 'glts/vim-textobj-comment'
NeoBundle 'gregsexton/gitv'
NeoBundle 'groenewege/vim-less'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'jwhitley/vim-matchit'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kurkale6ka/vim-pairs'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'paradigm/SkyBison'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tomasr/molokai'
NeoBundle 'tomasr/molokai'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Bck'
NeoBundle 'vim-scripts/L9'
NeoBundle 'vim-scripts/Vimchant'
NeoBundle 'vim-scripts/rainbow_parentheses.vim'

NeoBundleCheck

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

set regexpengine=0

set numberwidth=2
set shiftwidth=2
set softtabstop=2

set undofile
set undodir=~/.vim/undo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:droid_transparent = 0
let g:droid_day = 0

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * redraw!

syntax on
let g:seoul256_background = 234

" set g:solarized_termcolors = 256
" set g:solarized_termtrans=1
" colorscheme droid256
" colorscheme solarized
" colorscheme molokai
set background=dark
colorscheme seoul256

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

nnoremap ä :w<CR>

" Sama kun sublimen C-r
nnoremap <silent><space>f m':Unite -hide-status-line outline<CR>
" Sama kun sublimen C-p
nnoremap <silent><space>p :Unite -silent file_rec/async<CR>
nnoremap <silent><space>y :Unite -silent history/yank<CR>
nnoremap <silent><space>b :Unite -silent buffer_tab<CR>
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
let g:syntastic_python_checkers = ['pep8']
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
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter,FileType clojure RainbowParenthesesToggle
au Syntax,FileType clojure RainbowParenthesesLoadRound
au Syntax,FileType clojure RainbowParenthesesLoadSquare
au Syntax,FileType clojure RainbowParenthesesLoadBraces
set guioptions-=T  "remove toolbar
nnoremap K i<CR><Esc>k$
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

let g:arpeggio_timeoutlen=20
call arpeggio#map('i', '', 0, 'jk', '<Esc>')

" Sets all ignores for unite
function! SetUniteIgnores(...)
  " Add patterns to be ignored always
  let unite_ignore_always = [
    \'.git'
  \]

  let patterns = unite_ignore_always + a:000
  for value in patterns
    call add(regex, '\(' . value . '\)')
  endfor

  call unite#custom_source('file_rec/async', 'ignore_pattern', join(regex,'\|'))
endfun
autocmd BufReadPost,FileType javascript  call SetUniteIgnores(".*/app/components")

