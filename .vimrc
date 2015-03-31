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
set nowritebackup
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
if !has('nvim')
  set ttyfast
  set ttyscroll=1
endif
" Pretty character for vsplit separator
set fillchars+=vert:│
" Save vim undo history to file, so history persists through sessions
set undofile
set undodir=~/.vim/undo
set completeopt-=preview

if has("gui_gtk2")
  set guioptions=ca
  set guifont=Consolas\ 10
endif

" Colors
if $PRESENTATION_MODE == '1'
  let g:seoul256_transparent=1
endif
colorscheme seoul256
if $PRESENTATION_MODE == '1'
  set background=light
else
  set background=dark
endif

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
if has("nvim")
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

" Close window
nnoremap <M-q> <C-w>c
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
" New windows
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" Close buffer
nnoremap <M-w> :BD<cr>

" NOTE: To make windows equal size, <C-w>=
" Resize - Ctrl + jk
nnoremap <C-j> :res -5<cr>
nnoremap <C-k> :res +5<cr>

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

" Next/prev buffer
nnoremap <silent><space><C-p> :bprevious<CR>
nnoremap <silent><space><C-n> :bnext<CR>

" Quick macro stuff
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm!

" One more way to exit insert mode
inoremap <C-c> <ESC>
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
endif

" Split line
nnoremap <silent> <Plug>SplitLine i<CR><Esc>k$
      \ :call repeat#set("\<Plug>SplitLine")<CR>
nmap K <Plug>SplitLine

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

let g:Vertigo_homerow='asdfghjklö'
nnoremap <silent> <Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <Space>j :<C-U>VertigoDown v<CR>
onoremap <silent> <Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <Space>k :<C-U>VertigoUp v<CR>
onoremap <silent> <Space>k :<C-U>VertigoUp o<CR>

" Vim-rsi (readline insertmode bindings)
" Disable meta maps because <M-d> bindings breaks ä
let g:rsi_no_meta=1

" Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = ''
let g:airline_symbols.parse = 'ρ'

let g:airline#extensions#ctrlp#show_adjacent_modes = 0
let g:airline_theme='wombat'
let g:airline_exclude_preview = 1
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
let g:ycm_filetype_blacklist = {
      \ 'notes': 1,
      \ 'gitcommit': 1,
      \ 'markdown': 1,
      \ 'text': 1,
      \ }
let g:ycm_semantic_triggers = {
      \ 'haskell' : ['.'],
      \ }
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" Clojure options
autocmd BufNewFile,BufReadPost *.cljx,*.boot setfiletype clojure

" Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
let g:clojure_align_multiline_strings = 1

" These confict with my window bindings, tpopes plugin already has these bound
" to rational keys
" FIXME: Add raise bindings
let g:sexp_mappings = {
      \ 'sexp_swap_list_backward': '',
      \ 'sexp_swap_list_forward': '',
      \ 'sexp_swap_element_backward': '',
      \ 'sexp_swap_element_forward': '',
      \ 'sexp_move_to_prev_element_head': '',
      \ 'sexp_move_to_next_element_head': '',
      \ 'sexp_move_to_prev_element_tail': '',
      \ 'sexp_move_to_next_element_tail': '',
      \ 'sexp_raise_list':                '<LocalLeader>o',
      \ 'sexp_raise_element':             '<LocalLeader>O',
      \}
let g:sexp_enable_insert_mode_mappings = 0

" Check highlighting group of current char
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

autocmd FileType markdown set cc=80
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType markdown syntax match urls /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=@NoSpell
autocmd FileType markdown syntax match javapkg /\(java\|org\)\(\.[A-Za-z]\+\)\+/ contains=@NoSpell

" R
let vimrplugin_term="urxvt"

let g:sql_type_default = 'pgsql'

autocmd BufEnter    *    if &buftype == 'quickfix' | setlocal wrap | endif
autocmd BufWinEnter *    if &buftype == 'quickfix' | setlocal wrap | endif

autocmd VimResized  *    exe "normal! \<c-w>="

let g:lua_complete_omni = 1

let g:clj_fmt_autosave = 0
