if has("win16") || has("win32") || has("win64")
  execute "set rtp^=".expand("$HOME/.vim")
endif

if has('nvim')
  " Disable Python 2
  let g:loaded_python_provider = 1
  " let g:loaded_ruby_provider = 1

  runtime! plugin/python_setup.vim
endif

set rtp+=~/.fzf

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect(
      \ 'bundle/{}',
      \ 'bundle_clojure/{}',
      \ 'bundle_haskell/{}',
      \ 'bundle_lua/{}')

" Uses tpope's vim-sensible defaults

set hidden
set notimeout
set noswapfile
set nowritebackup
set nowrap
set nofoldenable
" lazyredraw flickers in alacritty, but perf seems ok without
set nolazyredraw
set number
set expandtab
set ignorecase
set smartcase
set noshowmode
set modeline

set noshowcmd

" Display whitespaces as nice unicode chars
set list
set listchars=""
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:█
" Enable g by default on substitute - that is, all matches in line are
" replaced. use s///g to substitute only first match.
set gdefault
" Shorten file messages:
" m [Modiefied] -> [+], r [readonly] -> [RO], I no welcome message
" c no match x of y for completion
set shortmess+=mrIc
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
" set sidescroll=1
" Pretty character for vsplit separator
set fillchars+=vert:│
" Save vim undo history to file, so history persists through sessions
set undofile
set undodir=~/.vim/undo
" set completeopt-=preview
set completeopt=noinsert,menuone,noselect
set signcolumn=yes

if has("gui_gtk2")
  set guioptions=ca
  set guifont=Consolas\ 10
endif

if has("mouse")
  set mouse=
endif

" Colors
" FIXME: Use thematic theme
if $PRESENTATION_MODE == '1'
  let g:seoul256_transparent=1
endif

let g:thematic#themes = {
      \ 'seoul256': {'background': 'dark'},
      \ 'presentation': {'colorscheme': 'seoul256',
      \                  'background': 'light',
      \                  'airline-theme': 'papercolor'},
      \ }

if $PRESENTATION_MODE == '1'
  let g:thematic#theme_name = 'presentation'
else
  let g:thematic#theme_name = 'seoul256'
endif

set termguicolors

" Mappings
let mapleader = ' '
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
nnoremap <silent> <M-w> <ESC>:Bdelete<CR>

" NOTE: To make windows equal size, <C-w>=
" Resize - Ctrl + jk
nnoremap <C-j> :res -5<cr>
nnoremap <C-k> :res +5<cr>

" Unbind Ex mode
nnoremap Q <nop>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Vim-switch
let g:switch_mapping = "<C-s>"

" Move parameters around
nmap <a <Plug>Argumentative_MoveLeft
nmap >a <Plug>Argumentative_MoveRight

" ctrl-p and space-p change file
" nmap <space>p :<C-u>GFiles<cr>
" nmap <space>p <Plug>(ctrlp)
" nnoremap <silent> <space>p :<C-u>CtrlPCurWD<cr>
" ctrl-b and space-b change buffer
" nnoremap <silent> <space>b :<C-u>CtrlPBuffer<cr>
nnoremap <silent> <C-b>    :<C-u>Clap buffers<cr>
" Project git files
nnoremap <silent> <C-p>    :<C-u>Clap gfiles<cr>
" Any files in current working directory (usually project folder)
nnoremap <silent> <C-P>    :<C-u>Clap files ++finder=rg --files <cr>
" Any files in cwd parent directory
nnoremap <silent> <M-p>    :<C-u>Clap files ++finder=rg --files ..<cr>

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

set cmdheight=2

set updatetime=500

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

let g:airline#extensions#ale#enabled = 0
" let g:airline#extensions#ctrlp#show_adjacent_modes = 0
let g:airline_theme='seoul256'
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

function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'capslock', 'iminsert'])
  " hunks disabled because it's empty for non-active buffers
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['%<', 'file', 'readonly'])
  let g:airline_section_gutter = airline#section#create(['%='])
  let g:airline_section_x = airline#section#create_right(['tagbar'])
  let g:airline_section_y = airline#section#create_right([])
  let g:airline_section_z = airline#section#create(['windowswap', 'linenr', ':%3v '])
  " let g:airline_section_warning = airline#section#create(['syntastic-warn', 'whitespace'])
endfunction
autocmd VimEnter * call AirlineInit()

" Syntastic
" let g:syntastic_python_checkers = ['pep8']
" let g:syntastic_check_on_open=1
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_java_checkers = ['']
" let g:syntastic_mode_map = {
"       \ 'mode': 'active',
"       \ 'active_filetypes': [],
"       \ 'passive_filetypes': [],
"       \ }
" let g:syntastic_error_symbol='✕'
" let g:syntastic_warning_symbol='✕'
" let g:syntastic_enable_highlighting = 0
" let g:syntastic_go_checkers = ['golint', 'govet']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }"

let g:loaded_syntastic_plugin = 1

" Ale

" Disable ALE
let g:loaded_ale_dont_use_this_in_other_plugins_please = 1

" Todo: replace syntastic with Ale?
let g:ale_linters_explicit = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_pattern_options = {
      \ '^iced_': {'ale_linters': [], 'ale_fixers': []},
      \}

let g:ale_set_quickfix = 0
" let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
" let g:ale_keep_list_window_open = 1

" FZF

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" CtrlP
" let g:ctrlp_extensions = ['line']
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_user_command = ['.git', "cd %s && git ls-files . -z --cached --exclude-standard | tr '\\0' '\n'"]
" When opening file with CtrlP always open in new buffer even if its already
" open somewhere
" let g:ctrlp_switch_buffer = '0'
" Open first file in current buffer, rest hidden
" let g:ctrlp_open_multiple_files = 'ri'
" let g:ctrlp_open_new_file = 'r'

" let g:ctrlp_buffer_func = {
"       \ 'enter': 'CtrlPMappings'
"       \ }

" function! s:DeleteBuffer()
"   let path = fnamemodify(getline('.')[2:], ':p')
"   let bufn = matchstr(path, '\v\d+\ze\*No Name')
"   exec "silent! bd" bufn ==# "" ? path : bufn
"   exec "silent! norm \<F5>"
" endfunction

" function! CtrlPMappings()
"   " Alt-w in ctrlp buffer view closes the selected buffer
"   nnoremap <buffer> <silent> <M-w> :call <sid>DeleteBuffer()<cr>
" endfunction

" Clojure options
autocmd BufNewFile,BufReadPost *.boot setfiletype clojure
" let g:refactor_nrepl_options = {'prefix-rewriting': 'false'}

" ' and ` are used alone in Clojure
au FileType clojure let b:delimitMate_quotes = "\""

" Fireplace, not used currently
" let g:fireplace_default_cljs_repl = ""

" Iced
let g:iced_formatter = 'zprint'
let g:iced_enable_auto_indent = v:false
let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true
let g:iced_enable_clj_kondo_analysis = v:true
let g:iced_enable_clj_kondo_local_analysis = v:true
let g:iced#buffer#stdout#max_line = 10000
let g:iced_enable_auto_document = ''
let g:iced#selector#search_order = ['clap']


" Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
let g:clojure_align_multiline_strings = 0
let g:clojure_maxlines = 200

" let g:leiningen_no_auto_repl = 1
let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'ctermfgs': ['204', '179', '146', '72', '225', '113', '75'],
      \ 'guifgs': [
      \     '#d7875f',
      \     '#d75f87',
      \     '#d7d700',
      \     '#5fafff',
      \     '#87d75f'
      \ ],
      \ 'separately': {
      \   'markdown': 0,
      \   'html': 0,
      \   'fzf': 0,
      \ }
      \ }

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
      \ 'sexp_raise_list':                '<LocalLeader>o',
      \ 'sexp_raise_element':             '<LocalLeader>O',
      \}
      " \ 'sexp_indent': '',
      " \ 'sexp_indent_top': '',
let g:sexp_enable_insert_mode_mappings = 0

" Check highlighting group of current char
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

" autocmd FileType json syntax match Comment +\/\/.\+$+

" let g:LanguageClient_settingsPath=".lsp/settings.json"

" R
let vimrplugin_term="urxvt"

let g:sql_type_default = 'pgsql'
let g:ftplugin_sql_omni_key = '<C-j>'

autocmd VimResized  *    exe "normal! \<c-w>="

let g:lua_complete_omni = 1

let g:vcoolor_disable_mappings = 1
nnoremap <silent><leader>c  :VCoolor<CR>

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown set cc=80
  autocmd FileType markdown syntax match urls /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=@NoSpell
  autocmd FileType markdown syntax match javapkg /\(java\|org\)\(\.[A-Za-z]\+\)\+/ contains=@NoSpell
augroup END

let g:magit_show_help=0

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>a :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

if !exists('g:grepper')
  let g:grepper = {}
endif
let g:grepper.prompt_quote = 2

let g:float_preview#docked = 0
let g:float_preview#max_width = 70

function! DisableExtras()
  call nvim_win_set_option(g:float_preview#win, 'number', v:false)
  call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
  call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
endfunction

autocmd User FloatPreviewWinOpen call DisableExtras()

autocmd FileType git,gitcommit,gitrebase,fugitiveblame nnoremap <buffer> <M-w> <C-w>c

autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy

" Ncm2

let g:ncm2#complete_delay = 400

autocmd BufEnter * call ncm2#enable_for_buffer()

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Clap

let g:clap_layout = { 'relative': 'editor' }
let g:clap_disable_run_rooter = 0
" let g:clap_open_preview = 'never'
let g:clap_preview_direction = 'UD'
" Close clap window using esc, instead of changing to normal mode.
let g:clap_insert_mode_only = v:true
let g:clap_multi_selection_warning_silent = 1

" - Disable close window and delete buffer binds on clap input
" - Disable change window binds
" These would break clap floating window.
" Even though M-w and move are only bound on normal mode, they still affect
" clap input?
" TODO: Move these to ftplugin after file?
autocmd FileType clap_input inoremap <silent> <buffer> <M-q> <Esc>:<c-u>call clap#handler#exit()<CR>
autocmd FileType clap_input inoremap <silent> <buffer> <M-w> <Esc>:<c-u>call clap#handler#exit()<CR>
autocmd FileType clap_input inoremap <silent> <buffer> <M-h> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-j> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-k> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-l> <nop>
" By default only on normal mode
" Goes to normal, invoke action, back to insert
autocmd FileType clap_input inoremap <silent> <buffer> <S-Tab> <Esc>:<c-u>call clap#action#invoke()<CR>i
" Note: If stuck with unfocused Clap floating window, run :Clap to return the
" focus and close normally.

nmap <silent> <M-1>l <Plug>(JumpRight)
nmap <M-1>h <Plug>(JumpLeft)
nmap <M-1>j <Plug>(JumpDown)
nmap <M-1>k <Plug>(JumpUp)
nmap <M-2>l <Plug>(MoveBufRight)
nmap <M-2>h <Plug>(MoveBufLeft)
nmap <M-2>j <Plug>(MoveBufDown)
nmap <M-2>k <Plug>(MoveBufUp)
nmap <M-3>l <Plug>(MoveJumpBufRight)
nmap <M-3>h <Plug>(MoveJumpBufLeft)
nmap <M-3>j <Plug>(MoveJumpBufDown)
nmap <M-3>k <Plug>(MoveJumpBufUp)
nmap <M-4>l <Plug>(MoveWinToNextTab)
nmap <M-4>h <Plug>(MoveWinToPrevTab)
nmap <M-5>l <Plug>(CopyBufRight)
nmap <M-5>h <Plug>(CopyBufLeft)
nmap <M-5>j <Plug>(CopyBufDown)
nmap <M-5>k <Plug>(CopyBufUp)
nmap <M-6>l <Plug>(CopyJumpBufRight)
nmap <M-6>h <Plug>(CopyJumpBufLeft)
nmap <M-6>j <Plug>(CopyJumpBufDown)
nmap <M-6>k <Plug>(CopyJumpBufUp)

" nmap <Leader>z <Plug>(MaximizeWin)

" nmap <silent> <Leader>B <Plug>(ClearAllWindows)
" nmap <silent> <Leader>b <Plug>(ClearBufferList)

" in init.vim
lua << EOF
  local lspconfig = require 'lspconfig'

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  lspconfig.clojure_lsp.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_change = 150,
    }
  }

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
EOF
