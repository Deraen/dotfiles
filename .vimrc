if has("win16") || has("win32") || has("win64")
  execute "set rtp^=".expand("$HOME/.vim")
endif

if has('nvim')
  runtime! plugin/python_setup.vim
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Uses tpope's vim-sensible defaults

set hidden
set notimeout
set noswapfile
set nowrap
set nofoldenable
set lazyredraw
set number
set expandtab
set ignorecase
set smartcase
set noshowmode
set modeline

" Display whitespaces as nice unicode chars
set list
set listchars=""
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:█
" Enable g by default on substitute - that is, all matches in line are
" replaced. use s///g to substitute only first match.
set gdefault
" Shorten file messages:
" m [Modiefied] -> [+], r [readonly] -> [RO], I no welcome message
set shortmess+=mrI
" Command completion. Complete till longest common string and show wildmenu.
set wildmode=longest:full
" Ignorecase when completing filenames on command prompt. e.g. ~/.xres -> ~/.Xresources
set wildignorecase
" Disable text and comment wrapping
set formatoptions-=tc
" Force fast tty. Should already be on when term is rxvt.
set ttyfast
set ttyscroll=1
" Pretty character for vsplit separator
set fillchars+=vert:│
" use + register for yank, delete and change operations
" NOTE: Testing if I miss this
" set clipboard+=unnamedplus
" Save vim undo history to file, so history persists through sessions
set undofile
set undodir=~/.vim/undo
" Hide status message when using completion, seems to be 'match x of y'
set completeopt-=preview

" Colors
set background=dark
colorscheme seoul256

" Mappings
let mapleader = 'å'
let maplocalleader = 'ö'

nnoremap ' `
nnoremap Y y$
set pastetoggle=<M-p>
nnoremap j gj
nnoremap k gk

" Save file
nnoremap ä :w<CR>

" Change active window, Alt
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
" Moving windows using, Alt + Shift
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L

" Close window
nnoremap <M-q> <C-w>c
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
" New windows
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" Close buffer
nnoremap <M-w> :BD<cr>

" NOTE: To make windows equal size, <C-w>=
" Resize - Ctrl + hjkl
nnoremap <C-j> :res -5<cr>
nnoremap <C-k> :res +5<cr>
" <C-l> would confict with redraw console
" I use these very rarely should it doesn't really matter that these are
" harder to use.
nnoremap <silent><space><C-h> :vert res -5<cr>
nnoremap <silent><space><C-l> :vert res +5<cr>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Vim-switch
nnoremap <C-s> :Switch<cr>

" Move parameters around
nmap <a <Plug>Argumentative_MoveLeft
nmap >a <Plug>Argumentative_MoveRight

" space-space toggles search hilight
nnoremap <silent><space><space> :set nohls!<cr>

" ctrl-p/space-p open files in project
nnoremap <silent><space>p :CtrlP<cr>
" space-l fuzzy search in current file
nnoremap <silent><space>l :CtrlPLine %<cr>
" space-b change buffer
nnoremap <silent><space>b :CtrlPBuffer<cr>

" Quick macro stuff
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm!

" One more way to exit insert mode
inoremap <C-c> <ESC>

" Split line
nnoremap <silent> <Plug>SplitLine i<CR><Esc>k$
      \ :call repeat#set("\<Plug>SplitLine")<CR>
nmap K <Plug>SplitLine

" Remove trailing whitespaces
function! StripTrailingWhitespaces()
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

let g:sneak#streak = 1
" replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" Vim-rsi (readline insertmode bindings)
" Disable meta maps because <M-d> bindings breaks ä
let g:rsi_no_meta=1

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
let g:airline#extensions#tagbar#enabled = 1

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
" let g:syntastic_enable_highlighting = 0

" CtrlP
let g:ctrlp_extensions = ['line']
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
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" Clojure options
" Use rainbow parentheses
au FileType clojure RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
autocmd BufNewFile,BufReadPost *.cljx,*.boot setfiletype clojure

" Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
let g:clojure_align_multiline_strings = 1

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

" Hightlight trailing spaces in normal mode
autocmd InsertEnter * match
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Check highlighting group of current char
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

autocmd FileType markdown set cc=80

" R
let vimrplugin_term="urxvt"

let g:gtfo#terminals = {
      \ 'unix': 'urxvt -cd'
      \ }

let g:sql_type_default = 'pgsql'
