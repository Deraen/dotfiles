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
NeoBundle 'vim-scripts/L9'
NeoBundle 'vim-scripts/Vimchant'
NeoBundle 'vim-scripts/rainbow_parentheses.vim'
NeoBundle 'guns/xterm-color-table.vim'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'editorconfig/editorconfig-vim'

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
set wildmenu
set wildmode=longest,list
set wildignorecase
set wrapmargin=0
set nonumber
set relativenumber
set scrolloff=100

" Use old one as new one might be slower?
set regexpengine=0

set numberwidth=3
set shiftwidth=2
set softtabstop=2

set undofile
set undodir=~/.vim/undo

" Colors
syntax on

set background=dark
colorscheme seoul256

" Mappings
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
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
nnoremap <M-c> :tabclose<cr>:echo ""<cr>
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" nnoremap <M-w> <C-w><C-w>
nnoremap <M-w> :bd<cr>

" Liikuttaa parametreja
" nmap <; <Plug>Argumentative_MoveLeft
" nmap >; <Plug>Argumentative_MoveRight

nnoremap ä :w<CR>

" Sama kun sublimen C-r
nnoremap <silent><space>f m':Unite -hide-status-line outline<CR>
" Sama kun sublimen C-p
nnoremap <silent><space>p :Unite -silent file_rec/async<CR>
nnoremap <silent><space>y :Unite -silent history/yank<CR>
nnoremap <silent><space>b :Unite -silent buffer_tab<CR>
nnoremap <silent><space>s :Startify<CR>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <backspace> <C-w>c
endfunction

function! ColorPicker(insert)
  let color = '\#' . expand('<cword>')
  let @z = system("zenity --color-selection --color " . color . " | cut -c 2-3,6-7,10-11 | tr -d \"\n\"")
  if strlen(@z) != 0
    if a:insert == 0
      normal! diw"zp
    else
      let @z = '#' . @z
      normal! "zp
    endif
  endif
endfunction
nnoremap <silent><space>c :call ColorPicker(0)<cr>
inoremap <silent><M-c> <C-o>:call ColorPicker(1)<cr>

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

nnoremap K i<CR><Esc>k$
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

let g:UltiSnipsExpandTrigger="<c-J>"
" let g:UltiSnipsListSnippets="<c-$>"
" let g:UltiSnipsJumpForwardTrigger="<c-J>"
" let g:UltiSnipsJumpBackwardTrigge="<c-k>"

fun! StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  silent! %s/\s\+$//e
  call cursor(l, c)
endfun
nnoremap <silent><space>dt :call StripTrailingWhitespaces()<CR>

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd InsertLeave * set nopaste

" Airline
" let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_whitespace=0
let g:airline_linecolumn_prefix = '¶'
let g:airline_branch_prefix = ''
let g:airline_paste_symbol = 'ρ'
let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
let g:airline_theme='wombat'
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
let g:bufferline_show_bufnr = 0

" Syntastic
let g:syntastic_python_checkers = ['pep8']
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': [],
      \ }
let g:syntastic_error_symbol='✕'
let g:syntastic_warning_symbol='✕'
let g:syntastic_enable_highlighting = 0

" Signify
let g:signify_sign_overwrite = 1
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'

" Unite
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

let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --column -i --ignore ".git" --hidden -g ""'

" ycm
" let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_identifier_chars = '_-/.><'
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_semantic_triggers = {
      \ 'clojure' : ['(', '/']
      \ }
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" Rainbow parenthesis
au VimEnter,FileType clojure RainbowParenthesesToggle
au Syntax,FileType clojure RainbowParenthesesLoadRound
au Syntax,FileType clojure RainbowParenthesesLoadSquare
au Syntax,FileType clojure RainbowParenthesesLoadBraces

" Arpegio
let g:arpeggio_timeoutlen=20
call arpeggio#map('icvx', '', 0, 'jk', '<Esc>')

" Hightlight trailing spaces
function! EnableTrailingHightlight()
  if exists('b:noTrailingHightlight')
    return
  endif
  match ExtraWhitespace /\s\+$/
endfunction

autocmd InsertEnter * match
autocmd InsertLeave * call EnableTrailingHightlight()
autocmd FileType unite let b:noTrailingHighlight = 1
" autocmd InsertLeave * redraw!

if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif

" Random
let g:indentLine_char = '│'
let g:skybison_fuzz = 1

