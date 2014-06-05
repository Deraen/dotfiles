" NeoBundle:
" git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'


NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'b4winckler/vim-angry'
NeoBundle 'baabelfish/a.vim'
NeoBundle 'baabelfish/vim-vertigo'
NeoBundle 'bling/vim-airline'
NeoBundle 'Deraen/seoul256.vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'drmikehenry/vim-fixkey'
NeoBundle 'elzr/vim-json'
NeoBundle 'glts/vim-textobj-comment'
NeoBundle 'gregsexton/gitv'
NeoBundle 'groenewege/vim-less'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'guns/vim-sexp' " Manipulate s-expressions (Lisp)
NeoBundle 'guns/xterm-color-table.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'justinmk/vim-sneak' " Like f but takes two chars
NeoBundle 'jwhitley/vim-matchit'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'kurkale6ka/vim-pairs'
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'mhinz/vim-toplevel'
NeoBundle 'mihaifm/bck'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'PeterRincker/vim-argumentative'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimproc', {'build': {'unix': 'make'}}
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'tomasr/molokai'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish' " %Subvert/faculit{y,ies}/building{,s}/g
NeoBundle 'tpope/vim-characterize' " Add unicode info to ga
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch' " Unix commands, :Remove etc.
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-fugitive' " Run git commands from Vim
NeoBundle 'tpope/vim-leiningen'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat' " . repeat support for some plugins
NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'
NeoBundle 'tpope/vim-sleuth' " Detect buffer settings (indent etc.)
NeoBundle 'tpope/vim-surround' " Change surrounding: cs, wrap entire line: yss
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'Valloric/YouCompleteMe' " ./install.sh --clang-completer --system-libclang
NeoBundle 'vim-scripts/bufkill.vim'

NeoBundleLazy 'marijnh/tern_for_vim', {'build': {'unix': 'npm install'}}
autocmd FileType javascript NeoBundleSource 'tern_for_vim'

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
set ttyfast
set ttyscroll=1
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
set smarttab
set ttimeout
set ttimeoutlen=0
set wildmenu
set wildmode=longest,list
set wildignorecase
set formatoptions-=tc
set wrapmargin=0
set number numberwidth=4
set scrolloff=100

" Use old one as new one might be slower?
set regexpengine=1

set numberwidth=3

set undofile
set undodir=~/.vim/undo

" Colors
syntax on

set background=dark
let g:seoul256_background = 233
colorscheme seoul256

" Mappings
let mapleader = 'ö'
let maplocalleader = 'ö'
" Pakko korjaukset
nnoremap ' `
nnoremap Y y$
set pastetoggle=<M-p>
nnoremap j gj
nnoremap k gk

" Change active window
nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l
" Moving windows using Alt
nnoremap <M-H> H
nnoremap <M-J> J
nnoremap <M-K> K
nnoremap <M-L> L

" Close window
nnoremap <M-q> <C-w>c
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
" New windows
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" Close buffer
nnoremap <M-w> :BD<cr>

" Resize
nnoremap <C-j> :res -5<cr>
nnoremap <C-k> :res +5<cr>
" I don't seem to use these and ctrl-l conflicts with `clear terminal`
" nnoremap <C-h> :vert res -5<cr>
" nnoremap <C-l> :vert res +5<cr>

" Move parameters around
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight

" Save file
nnoremap ä :w<CR>

" space-space toggles search hilight
nnoremap <silent><space><space> :set nohls!<cr>

" ctrl-p open files in project, ctrl-b change buffer
nnoremap <silent><space>p :CtrlP<cr>
nnoremap <silent><space>b :CtrlPBuffer<cr>

" FIXME: seems to have problems...
function! ColorPicker(insert)
  let color = '\#' . expand('<cword>')
  let @z = system("zenity --color-selection --color " . color . " | cut -c 2-3,6-7,10-11 | tr -d \"\n\"")
  if strlen(@z) != 0
    if a:insert == 0
      normal! diw"zP
    else
      let @z = '#' . @z
      normal! "zp
    endif
  endif
endfunction
nnoremap <silent><space>c :call ColorPicker(0)<cr>
inoremap <silent><M-c> <C-o>:call ColorPicker(1)<cr>

" Toggle buffer fullscreen
let g:dfm_fullscreen=0
let g:dfm_nd=0
function! Fullscreen()
  if g:dfm_nd
    call NoDistraction()
  endif
  if g:dfm_fullscreen
    tab close
    set showtabline=1
  else
    tab split
    set showtabline=0
  endif
  let g:dfm_fullscreen=!g:dfm_fullscreen
endfunction

nnoremap <silent><M-f> :call Fullscreen()<cr>:echo ""<cr>

" Quick macro stuff
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm!

" One more way to exit insert mode
inoremap <C-c> <ESC>

" Split line
nnoremap K i<CR><Esc>k$

" Search in project for these words
nnoremap <silent><space>/f :Bck FIXME<CR>
nnoremap <silent><space>/t :Bck TODO<CR>
" Search for word under the cursor
nnoremap <silent><space>/w :Bck <C-r><C-w><CR>
nnoremap <silent><space>q :Bck<CR>

" Remove trailing whitespaces
fun! StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  silent! %s/\s\+$//e
  call cursor(l, c)
endfun
nnoremap <silent><space>dt :call StripTrailingWhitespaces()<CR>     

" Hightlight trailing whitespaces in normal mode
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

nnoremap <silent> <Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <Space>j :<C-U>VertigoDown v<CR>
onoremap <silent> <Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <Space>k :<C-U>VertigoUp v<CR>
onoremap <silent> <Space>k :<C-U>VertigoUp o<CR>

" Airline
let g:airline_detect_whitespace=1
let g:airline_linecolumn_prefix = '¶'
let g:airline_branch_prefix = ''
let g:airline_paste_symbol = 'ρ'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
let g:airline_theme='wombat'
let g:airline_detect_modified=1
let g:airline_exclude_preview = 0
let g:airline_inactive_collapse = 0
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
" let g:airline_powerline_fonts=1

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

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']
" When opening file with CtrlP always open in new buffer even if its already
" open somewhere
let g:ctrlp_switch_buffer = '0'
" Open first file in current buffer, rest hidden
let g:ctrlp_open_multiple_files = 'ri'
let g:ctrlp_open_new_file = 'r'

let g:ctrlp_buffer_func = {
      \ 'enter': 'CtrlPMappings'
      \ }

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

function! CtrlPMappings()
  " Alt-w in ctrlp buffer view closes the selected buffer
  nnoremap <buffer> <silent> <M-w> :call <sid>DeleteBuffer()<cr>
endfunction

" Bck
let g:BckPrg = 'ag --nocolor --nogroup --column -i --ignore ".git" --hidden'
let BckOptions = 'cirw'

" ycm
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_identifier_chars = '_-/.><'
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
let g:ycm_filetype_blacklist = {
      \ 'notes': 1,
      \ 'gitcommit': 1,
      \ 'vim': 1,
      \ 'markdown': 1,
      \ 'text': 1,
      \}
set completeopt-=preview

" Clojure options
" Use rainbow parentheses
au FileType clojure RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound

let g:clojure_align_multiline_strings = 1

" Lispwords are words after which indentation should always be 2 spaces
" instead of justifying elements to same level as previous lines elements

" Define compojure routes using regex so GET and GET* both match
let g:clojure_fuzzy_indent_patterns=['^GET', '^POST', '^PUT', '^DELETE', '^ANY', '^HEAD', '^PATCH', '^OPTIONS', '^def']

autocmd FileType clojure execute "setlocal lispwords+=" . join(map(values({
      \ 'random': ['describe', 'it', 'testing'],
      \ 'compojure': ['context', 'swaggered'],
      \ 'midje': ['fact', 'facts', 'provided'],
      \ 'core.logic': ['run*']
      \}), 'join(v:val, ",")'), ',')

" These confict with my window bindings, tpopes plugin already has these bound
" to rational keys
let g:sexp_mappings = {
      \ 'sexp_swap_list_backward': '',
      \ 'sexp_swap_list_forward': '',
      \ 'sexp_swap_element_backward': '',
      \ 'sexp_swap_element_forward': '',
      \ 'sexp_move_to_prev_element_head': '',
      \ 'sexp_move_to_next_element_head': '',
      \ 'sexp_move_to_prev_element_tail': '',
      \ 'sexp_move_to_next_element_tail': '',
      \}
let g:sexp_enable_insert_mode_mappings = 0

" Arpegio
let g:arpeggio_timeoutlen=25
call arpeggio#map('icvx', '', 0, 'jk', '<Esc>')
call arpeggio#map('icvx', '', 0, 'jl', '<End>')
" call arpeggio#map('icvx', '', 0, 'ui', '<Esc>u')
call arpeggio#map('i', '', 0, 'hl', '<Esc>I')

" Hightlight trailing spaces in normal mode
function! EnableTrailingHightlight()
  if exists('b:noTrailingHightlight')
    return
  endif
  match ExtraWhitespace /\s\+$/
endfunction

autocmd InsertEnter * match
autocmd InsertLeave * call EnableTrailingHightlight()
autocmd FileType ctrlp let b:noTrailingHighlight = 1
" autocmd InsertLeave * redraw!

if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif

" Random
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

" autocmd FileType tex set filetype=plaintex
